import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class GetJobsUseCase {
  final JobRepository _repository;

  GetJobsUseCase(this._repository);

  Future<JobResponseEntity> call({
    int page = 1,
    int pageSize = 10,
    String? status,
    String? search,
  }) async {
    return await _repository.getJobs(
      page: page,
      pageSize: pageSize,
      status: status,
      search: search,
    );
  }
}
