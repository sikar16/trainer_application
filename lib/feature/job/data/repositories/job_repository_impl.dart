import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource _remoteDataSource;

  JobRepositoryImpl(this._remoteDataSource);

  @override
  Future<JobResponseEntity> getJobs({
    int page = 1,
    int pageSize = 10,
    String? status,
    String? search,
  }) async {
    final jobModel = await _remoteDataSource.getJobs(
      page: page,
      pageSize: pageSize,
      status: status,
      search: search,
    );
    return JobResponseEntity(
      jobs: jobModel.jobs,
      totalPages: jobModel.totalPages,
      totalElements: jobModel.totalElements,
      code: jobModel.code,
      message: jobModel.message,
    );
  }
}
