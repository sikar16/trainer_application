import '../entities/trainee_entity.dart';

abstract class TraineeRepository {
  Future<TraineeListEntity> getTraineesByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  });
}
