import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/job_detail_bloc/job_detail_bloc.dart';
import '../bloc/job_application_bloc/job_application_bloc.dart';
import '../../domain/entities/job_detail_entity.dart';
import '../../../../core/di/injection_container.dart' as sl;

class JobDetailScreen extends StatelessWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl.sl<JobDetailBloc>()..add(FetchJobDetail(jobId)),
        ),
        BlocProvider(create: (context) => sl.sl<JobApplicationBloc>()),
      ],
      child: const JobDetailView(),
    );
  }
}

class JobDetailView extends StatefulWidget {
  const JobDetailView({super.key});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  bool _showApplicationForm = false;
  String _selectedApplicationType = 'Main Trainer';
  final TextEditingController _reasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final jobId =
        (context.findAncestorWidgetOfExactType<JobDetailScreen>()?.jobId) ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/job');
          },
        ),
        title: const Text('Job Details'),
        centerTitle: true,
      ),
      body: BlocListener<JobApplicationBloc, JobApplicationState>(
        listener: (context, state) {
          if (state is JobApplicationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Application submitted successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
            setState(() {
              _showApplicationForm = false;
              _reasonController.clear();
            });
          } else if (state is JobApplicationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<JobDetailBloc, JobDetailState>(
          builder: (context, state) {
            if (state is JobDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is JobDetailError) {
              return Center(
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
                          FetchJobDetail(jobId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is JobDetailLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildJobContent(
                          context,
                          state.jobDetail.job,
                          colorScheme,
                        ),
                        if (_showApplicationForm) _buildApplicationForm(),
                      ]),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No job data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildJobContent(
    BuildContext context,
    JobDetailEntity job,
    ColorScheme colorScheme,
  ) {
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

        _buildActionButtons(context, colorScheme),
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

  Widget _buildActionButtons(BuildContext context, ColorScheme colorScheme) {
    if (_showApplicationForm) {
      return const SizedBox();
    }

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
            onPressed: () {
              setState(() {
                _showApplicationForm = true;
              });
            },
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

  Widget _buildApplicationForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Application Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedApplicationType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Main Trainer',
                  child: Text('Main Trainer'),
                ),
                DropdownMenuItem(
                  value: 'Assistant Trainer',
                  child: Text('Assistant Trainer'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedApplicationType = value!;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Why do you want to apply for this position?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _reasonController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your reason',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your reason';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _showApplicationForm = false;
                        _reasonController.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BlocBuilder<JobApplicationBloc, JobApplicationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is JobApplicationLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final jobId =
                                      (context
                                          .findAncestorWidgetOfExactType<
                                            JobDetailScreen
                                          >()
                                          ?.jobId) ??
                                      '';
                                  context.read<JobApplicationBloc>().add(
                                    SubmitJobApplication(
                                      jobId: jobId,
                                      reason: _reasonController.text.trim(),
                                      applicationType: _selectedApplicationType,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: state is JobApplicationLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Submit Application',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
