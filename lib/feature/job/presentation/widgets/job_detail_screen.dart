import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/job_detail_bloc.dart';
import '../../domain/entities/job_detail_entity.dart';
import '../../../../core/di/injection_container.dart' as sl;

class JobDetailScreen extends StatelessWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.sl<JobDetailBloc>()..add(FetchJobDetail(jobId)),
      child: const JobDetailView(),
    );
  }
}

class JobDetailView extends StatelessWidget {
  const JobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: BlocBuilder<JobDetailBloc, JobDetailState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state is JobDetailLoaded
                        ? state.jobDetail.job.title
                        : 'Job Details',
                  ),
                ),

                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/job'),
                ),
                floating: true,
                pinned: true,
              ),
              if (state is JobDetailLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is JobDetailError)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error loading job details',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Get the jobId from the bloc or pass it differently
                            context.read<JobDetailBloc>().add(
                              FetchJobDetail(''),
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              else if (state is JobDetailLoaded)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildJobContent(state.jobDetail.job, colorScheme),
                    ]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildJobContent(JobDetailEntity job, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Number of Sessions - ${job.numberOfSessions}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const Divider(height: 32, thickness: 1),
        Text(
          job.description,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const Divider(height: 32, thickness: 1),
        if (job.sessions.isNotEmpty) ...[
          Text(
            'Session 1',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Text(
              job.sessions.first.deliveryMethod == 'OFFLINE'
                  ? 'In Person'
                  : 'Online',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailRow(
                  icon: Icons.calendar_today,
                  text: _formatDate(job.sessions.first.startDate),
                ),
              ),
              Expanded(
                child: _buildDetailRow(
                  icon: Icons.schedule,
                  text: _formatTime(job.sessions.first.startDate),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDetailRow(
                  icon: Icons.timer,
                  text:
                      '${_calculateDuration(job.sessions.first.startDate, job.sessions.first.endDate)} mins',
                ),
              ),
              Expanded(
                child: _buildDetailRow(
                  icon: Icons.location_on,
                  text: job.sessions.first.trainingVenue.location,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            job.sessions.first.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Divider(height: 32, thickness: 1),
        ],
        _buildTablesSection(job),
        const SizedBox(height: 32),
        _buildActionButtons(colorScheme),
      ],
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildTablesSection(JobDetailEntity job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTableColumn(
                title: 'Start On',
                value: _formatDate(job.createdAt),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTableColumn(
                title: 'Ends On',
                value: _formatDate(job.deadlineDate),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTableColumn(
                title: 'Number of Sessions',
                value: job.numberOfSessions.toString(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTableColumn(
                title: 'Applicants Required',
                value: job.applicantsRequired.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableColumn({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Decline',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Apply',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  int _calculateDuration(String startDate, String endDate) {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      return end.difference(start).inMinutes;
    } catch (e) {
      return 0;
    }
  }
}
