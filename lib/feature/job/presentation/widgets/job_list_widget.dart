import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/job_bloc.dart';
import '../../../../core/di/injection_container.dart' as sl;

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
        _searchBar(),
        const SizedBox(height: 16),
        _filterTabs(),
        const SizedBox(height: 16),
        Expanded(child: _content()),
      ],
    );
  }

  Widget _searchBar() {
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

  Widget _filterTabs() {
    return Row(
      children: [
        _filterItem("View All", () {
          setState(() => _selectedFilter = "View All");
          _jobBloc.add(FetchJobs());
        }),
        const SizedBox(width: 12),
        _filterItem("Active", () {
          setState(() => _selectedFilter = "Active");
          _jobBloc.add(FilterJobsByStatus('ACTIVE'));
        }),
        const SizedBox(width: 12),
        _filterItem("Inactive", () {
          setState(() => _selectedFilter = "Inactive");
          _jobBloc.add(FilterJobsByStatus('INACTIVE'));
        }),
      ],
    );
  }

  Widget _filterItem(String title, VoidCallback onTap) {
    final bool selected = _selectedFilter == title;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
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
  final String title;
  final String createdAt;
  final String deadlineDate;
  final String description;
  final String status;
  final int sessions;
  final int applicantsRequired;

  const JobCard({
    super.key,
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 8),
                  Text("-", style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(width: 8),
                  Text(
                    deadlineDate,
                    style: TextStyle(color: Colors.grey.shade600),
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
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                "3 months ago",
                style: TextStyle(color: Colors.grey.shade600),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: InkWell(
                onTap: () => GoRouter.of(context).go('/job_detail'),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
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
}
