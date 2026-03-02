import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/job_bloc/job_bloc.dart';
import '../bloc/job_detail_bloc/job_detail_bloc.dart';
import '../bloc/job_application_bloc/job_application_bloc.dart';
import '../../../../core/di/injection_container.dart' as sl;
import 'job_detail_screen.dart';

class JobListWidget extends StatefulWidget {
  const JobListWidget({super.key});

  @override
  State<JobListWidget> createState() => _JobListWidgetState();
}

class _JobListWidgetState extends State<JobListWidget> {
  late JobBloc _jobBloc;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  String _selectedFilter = "View All";

  @override
  void initState() {
    super.initState();
    _jobBloc = sl.sl<JobBloc>();
    _jobBloc.add(FetchJobs());
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _jobBloc.close();
    _scrollController.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _jobBloc.add(LoadMoreJobs());
    }
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        _jobBloc.add(SearchJobs(query));
      } else {
        _jobBloc.add(FetchJobs());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _searchBar(), // Commented out search functionality
        // const SizedBox(height: 16),
        // _filterTabs(), // Commented out filter functionality
        const SizedBox(height: 16),
        Expanded(child: _content()),
      ],
    );
  }

  Widget searchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search jobs...",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _jobBloc.add(FetchJobs());
                },
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 1, height: 28, color: Colors.grey.shade300);
  }

  Widget _segmentItem(
    String title, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final bool selected = _selectedFilter == title;

    return InkWell(
      onTap: () {
        setState(() => _selectedFilter = title);

        if (title == "View All") {
          _jobBloc.add(FetchJobs());
        } else if (title == "Active") {
          _jobBloc.add(FilterJobsByStatus('ACTIVE'));
        }
      },
      borderRadius: BorderRadius.horizontal(
        left: isFirst ? const Radius.circular(12) : Radius.zero,
        right: isLast ? const Radius.circular(12) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(12) : Radius.zero,
            right: isLast ? const Radius.circular(12) : Radius.zero,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget filterTabs() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segmentItem("View All", isFirst: true),
          _verticalDivider(),
          _segmentItem("Active"),
          _verticalDivider(),
          _segmentItem("New", isLast: true),
        ],
      ),
    );
  }

  Widget _content() {
    return BlocBuilder<JobBloc, JobState>(
      bloc: _jobBloc,
      builder: (context, state) {
        if (state is JobLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is JobError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is JobLoaded) {
          return _jobList(state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _jobList(JobLoaded state) {
    final jobs = state.jobs;
    if (jobs.isEmpty) {
      return _emptyState();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            itemCount: jobs.length + (state.isLoadingMore ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index == jobs.length && state.isLoadingMore) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final job = jobs[index];
              return JobCard(
                id: job.id,
                title: job.title,
                createdAt: _formatDate(job.createdAt),
                deadlineDate: _formatDate(job.deadlineDate),
                description: job.description,
                status: job.status,
                sessions: job.numberOfSessions,
                applicantsRequired: job.applicantsRequired,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.work_outline, size: 48, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Text(
          "No Jobs Available",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "There are currently no jobs available.\nCheck back later.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class JobCard extends StatelessWidget {
  final String id;
  final String title;
  final String createdAt;
  final String deadlineDate;
  final String description;
  final String status;
  final int sessions;
  final int applicantsRequired;

  const JobCard({
    super.key,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.deadlineDate,
    required this.description,
    required this.status,
    required this.sessions,
    required this.applicantsRequired,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Row(
                children: [
                  Text(
                    createdAt,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "-",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    deadlineDate,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.menu_book_outlined,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                "$sessions Sessions",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                "3 months ago",
                style: TextStyle(color: colorScheme.primary, fontSize: 10),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: themeColor),
                foregroundColor: themeColor,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: InkWell(
                onTap: () => _showJobDetailDialog(context, id, title),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Text(
                    "View Detaile",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showJobDetailDialog(BuildContext context, String id, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        sl.sl<JobDetailBloc>()..add(FetchJobDetail(id)),
                  ),
                  BlocProvider(
                    create: (context) => sl.sl<JobApplicationBloc>(),
                  ),
                ],
                child: JobDetailView(),
              ),
            ),
          ),
        );
      },
    );
  }
}
