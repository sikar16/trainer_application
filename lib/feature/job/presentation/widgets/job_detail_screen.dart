import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/job_detail_bloc/job_detail_bloc.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<JobDetailBloc, JobDetailState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                title: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Job Details'),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/job'),
                ),
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
                        const Text(
                          'Error loading job details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(state.message, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
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
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Number of Sessions • ${job.numberOfSessions}',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),

        const SizedBox(height: 16),

        Card(
          elevation: 0,
          color: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              job.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ),

        const SizedBox(height: 24),

        if (job.sessions.isNotEmpty) _buildSessionCard(job),

        const SizedBox(height: 24),

        _buildDetailSection(job),

        const SizedBox(height: 32),

        _buildActionButtons(colorScheme),
      ],
    );
  }

  Widget _buildSessionCard(JobDetailEntity job) {
    final session = job.sessions.first;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${job.numberOfSessions} Sessions',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),

                _buildChip(
                  session.deliveryMethod == 'OFFLINE' ? 'In Person' : 'Online',
                ),
              ],
            ),

            const SizedBox(height: 26),

            Row(
              children: [
                Expanded(
                  child: _buildJobDetailRow(
                    icon: Icons.calendar_today,
                    text: _formatDate(session.startDate),
                  ),
                ),

                Expanded(
                  child: _buildJobDetailRow(
                    icon: Icons.schedule,
                    text: _formatTime(session.startDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildJobDetailRow(
                    icon: Icons.group,
                    text: '${session.numberOfStudents} ',
                  ),
                ),
                Expanded(
                  child: _buildJobDetailRow(
                    icon: Icons.location_on,
                    text: session.trainingVenue.location,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(JobDetailEntity job) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(
              leftTitle: 'Start On',
              leftValue: _formatDate(job.createdAt),
              rightTitle: 'Ends On',
              rightValue: _formatDate(job.deadlineDate),
            ),
            const SizedBox(height: 20),

            _buildInfoRow(
              leftTitle: 'Number of Sessions',
              leftValue: job.numberOfSessions.toString(),
              rightTitle: 'Applicants Required',
              rightValue: job.applicantsRequired.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Decline',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Text(text, style: const TextStyle(color: Colors.blue)),
    );
  }

  Widget _buildJobDetailRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String leftTitle,
    required String leftValue,
    required String rightTitle,
    required String rightValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoColumn(leftTitle, leftValue),
        _buildInfoColumn(rightTitle, rightValue),
      ],
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM d, y').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return dateString;
    }
  }
}
