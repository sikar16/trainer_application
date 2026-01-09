import '../entities/cohort_entity.dart';

abstract class CohortRepository {
  Future<CohortListEntity> getCohorts({
    required String trainingId,
    int page = 1,
    int pageSize = 100,
  });
}
