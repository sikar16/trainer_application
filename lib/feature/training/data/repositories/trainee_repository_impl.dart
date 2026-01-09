import '../../domain/entities/trainee_entity.dart';
import '../../domain/repositories/trainee_repository.dart';
import '../datasources/trainee_remote_data_source.dart';

class TraineeRepositoryImpl implements TraineeRepository {
  final TraineeRemoteDataSource remoteDataSource;

  TraineeRepositoryImpl(this.remoteDataSource);

  @override
  Future<TraineeListEntity> getTraineesByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  }) {
    return remoteDataSource.getTraineesByCohort(
      cohortId: cohortId,
      page: page,
      pageSize: pageSize,
    );
  }
}
