import '../../domain/repositories/job_detail_repository.dart';
import '../datasources/job_detail_remote_data_source.dart';
import '../../domain/entities/job_detail_entity.dart';

class JobDetailRepositoryImpl implements JobDetailRepository {
  final JobDetailRemoteDataSource _remoteDataSource;

  JobDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<JobDetailResponseEntity> getJobDetail(String jobId) async {
    final jobDetailModel = await _remoteDataSource.getJobDetail(jobId);
    return jobDetailModel.toEntity();
  }
}
