import '../entities/job_entity.dart';

abstract class JobRepository {
  Future<JobResponseEntity> getJobs({
    int page = 1,
    int pageSize = 10,
    String? status,
    String? search,
  });
}
