import '../entities/cohort_entity.dart';
import '../repositories/cohort_repository.dart';

class GetCohortsUseCase {
  final CohortRepository repository;

  GetCohortsUseCase(this.repository);

  Future<CohortListEntity> call({
    required String trainingId,
    int page = 1,
    int pageSize = 100,
  }) {
    return repository.getCohorts(
      trainingId: trainingId,
      page: page,
      pageSize: pageSize,
    );
  }
}
