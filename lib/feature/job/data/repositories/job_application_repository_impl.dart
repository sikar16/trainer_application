import '../../domain/repositories/job_application_repository.dart';
import '../datasources/job_application_remote_data_source.dart';

class JobApplicationRepositoryImpl implements JobApplicationRepository {
  final JobApplicationRemoteDataSource remoteDataSource;

  JobApplicationRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitJobApplication({
    required String jobId,
    required String reason,
    required String applicationType,
  }) async {
    await remoteDataSource.submitJobApplication(
      jobId: jobId,
      reason: reason,
      applicationType: applicationType,
    );
  }
}
