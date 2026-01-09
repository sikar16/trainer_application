import '../../domain/entities/cohort_entity.dart';
import '../../domain/repositories/cohort_repository.dart';
import '../datasources/cohort_remote_data_source.dart';

class CohortRepositoryImpl implements CohortRepository {
  final CohortRemoteDataSource remoteDataSource;

  CohortRepositoryImpl(this.remoteDataSource);

  @override
  Future<CohortListEntity> getCohorts({
    required String trainingId,
    int page = 1,
    int pageSize = 100,
  }) {
    return remoteDataSource.getCohorts(
      trainingId: trainingId,
      page: page,
      pageSize: pageSize,
    );
  }
}
