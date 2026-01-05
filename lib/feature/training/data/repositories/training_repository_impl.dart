import '../../domain/entities/training_entity.dart';
import '../../domain/repositories/training_repository.dart';
import '../datasources/training_remote_data_source.dart';

class TrainingRepositoryImpl implements TrainingRepository {
  final TrainingRemoteDataSource remoteDataSource;

  TrainingRepositoryImpl(this.remoteDataSource);

  @override
  Future<TrainingListEntity> getTrainings({int page = 1, int pageSize = 10}) {
    return remoteDataSource.getTrainings(page: page, pageSize: pageSize);
  }

  @override
  Future<TrainingEntity> getTrainingById(String id) {
    return remoteDataSource.getTrainingById(id);
  }
}
