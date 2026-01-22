import '../repositories/job_application_repository.dart';

class SubmitJobApplicationUseCase {
  final JobApplicationRepository repository;

  SubmitJobApplicationUseCase(this.repository);

  Future<void> call({
    required String jobId,
    required String reason,
    required String applicationType,
  }) {
    return repository.submitJobApplication(
      jobId: jobId,
      reason: reason,
      applicationType: applicationType,
    );
  }
}
