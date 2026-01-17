import '../repositories/job_detail_repository.dart';
import '../entities/job_detail_entity.dart';

class GetJobDetailUseCase {
  final JobDetailRepository _repository;

  GetJobDetailUseCase(this._repository);

  Future<JobDetailResponseEntity> call(String jobId) async {
    return await _repository.getJobDetail(jobId);
  }
}
