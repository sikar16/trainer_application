import '../../domain/entities/job_detail_entity.dart';

abstract class JobDetailRepository {
  Future<JobDetailResponseEntity> getJobDetail(String jobId);
}
