abstract class JobApplicationRepository {
  Future<void> submitJobApplication({
    required String jobId,
    required String reason,
    required String applicationType,
  });
}
