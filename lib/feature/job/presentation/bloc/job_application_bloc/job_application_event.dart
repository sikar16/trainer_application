part of 'job_application_bloc.dart';

abstract class JobApplicationEvent extends Equatable {
  const JobApplicationEvent();

  @override
  List<Object> get props => [];
}

class SubmitJobApplication extends JobApplicationEvent {
  final String jobId;
  final String reason;
  final String applicationType;

  const SubmitJobApplication({
    required this.jobId,
    required this.reason,
    required this.applicationType,
  });

  @override
  List<Object> get props => [jobId, reason, applicationType];
}
