import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/application_entity.dart';
import '../../domain/usecases/get_applications_usecase.dart';

enum ApplicationFilter { all, accepted, rejected, pending }

class ApplicationListWidget extends StatefulWidget {
  const ApplicationListWidget({super.key});

  @override
  State<ApplicationListWidget> createState() => _ApplicationListWidgetState();
}

class _ApplicationListWidgetState extends State<ApplicationListWidget> {
  ApplicationFilter selectedFilter = ApplicationFilter.all;
  List<ApplicationEntity> applications = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  Future<void> _loadApplications() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await sl<GetApplicationsUseCase>()();
      setState(() {
        applications = response.applications;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _filterTabs(),
        const SizedBox(height: 16),
        Expanded(child: _content()),
      ],
    );
  }

  Widget _filterTabs() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _segmentItem("View All", ApplicationFilter.all, isFirst: true),
            _verticalDivider(),
            _segmentItem("Accepted", ApplicationFilter.accepted),
            _verticalDivider(),
            _segmentItem("Rejected", ApplicationFilter.rejected),
            _verticalDivider(),
            _segmentItem("Pending", ApplicationFilter.pending, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _segmentItem(
    String title,
    ApplicationFilter filter, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final bool selected = selectedFilter == filter;

    return InkWell(
      onTap: () => setState(() => selectedFilter = filter),
      borderRadius: BorderRadius.horizontal(
        left: isFirst ? const Radius.circular(12) : Radius.zero,
        right: isLast ? const Radius.circular(12) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
            fontSize: 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(width: 1, height: 28, color: Colors.grey.shade300);
  }

  Widget _content() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading applications',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadApplications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    switch (selectedFilter) {
      case ApplicationFilter.all:
        return _applicationList("All Applications", _getFilteredApplications());
      case ApplicationFilter.accepted:
        return _applicationList(
          "Accepted Applications",
          _getFilteredApplications(),
        );
      case ApplicationFilter.rejected:
        return _applicationList(
          "Rejected Applications",
          _getFilteredApplications(),
        );
      case ApplicationFilter.pending:
        return _applicationList(
          "Pending Applications",
          _getFilteredApplications(),
        );
    }
  }

  List<ApplicationEntity> _getFilteredApplications() {
    switch (selectedFilter) {
      case ApplicationFilter.all:
        return applications;
      case ApplicationFilter.accepted:
        return applications.where((app) => app.status == 'ACCEPTED').toList();
      case ApplicationFilter.rejected:
        return applications.where((app) => app.status == 'REJECTED').toList();
      case ApplicationFilter.pending:
        return applications.where((app) => app.status == 'PENDING').toList();
    }
  }

  Widget _applicationList(
    String title,
    List<ApplicationEntity> filteredApplications,
  ) {
    if (filteredApplications.isEmpty) {
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
          Text(
            "No $title Available",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "There are currently no applications available.\nCheck back later.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredApplications.length,
      itemBuilder: (context, index) {
        final application = filteredApplications[index];
        return _applicationCard(application);
      },
    );
  }

  Widget _applicationCard(ApplicationEntity application) {
    final themeColor = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  application.job.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(application.createdAt),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${application.job.numberOfSessions} Sessions",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Text(
                  application.reason,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (MediaQuery.of(context).size.width > 360)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Applied as:",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _getAppliedRole(application.applicationType),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _statusChip(application.status),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 4),

          Text(
            _getTimeAgo(application.createdAt),
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          if (MediaQuery.of(context).size.width <= 360) ...[
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Applied as:",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  _getAppliedRole(application.applicationType),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                _statusChip(application.status),
              ],
            ),
          ],

          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                GoRouter.of(
                  context,
                ).go('/job_detail/${application.job.id}?applied=true');
              },
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "View Detail",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status) {
      case 'ACCEPTED':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        displayText = 'Accepted';
        break;
      case 'REJECTED':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        displayText = 'Rejected';
        break;
      case 'PENDING':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        displayText = 'Pending';
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return 'about ${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return 'about ${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'about 1 day ago';
    } else {
      return 'about ${difference.inDays} days ago';
    }
  }

  String _getAppliedRole(String applicationType) {
    switch (applicationType) {
      case 'MAIN':
        return 'Main Trainer';
      case 'ASSISTANT':
        return 'Assistant Trainer';
      default:
        return 'Trainer';
    }
  }
}
