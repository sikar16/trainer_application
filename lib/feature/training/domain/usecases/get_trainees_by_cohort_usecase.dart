import '../entities/trainee_entity.dart';
import '../repositories/trainee_repository.dart';

class GetTraineesByCohortUseCase {
  final TraineeRepository repository;

  GetTraineesByCohortUseCase(this.repository);

  Future<TraineeListEntity> call({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  }) {
    return repository.getTraineesByCohort(
      cohortId: cohortId,
      page: page,
      pageSize: pageSize,
    );
  }
}
