import '../../domain/entities/training_profile_entity.dart';
import '../../domain/repositories/training_profile_repository.dart';
import '../datasources/training_profile_remote_data_source.dart';

class TrainingProfileRepositoryImpl implements TrainingProfileRepository {
  final TrainingProfileRemoteDataSource _remoteDataSource;

  TrainingProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<TrainingProfileResponseEntity> getTrainingProfile(
    String trainingId,
  ) async {
    final trainingProfileModel = await _remoteDataSource.getTrainingProfile(
      trainingId,
    );
    return TrainingProfileResponseEntity(
      trainingProfile: trainingProfileModel.trainingProfile,
      code: trainingProfileModel.code,
      message: trainingProfileModel.message,
    );
  }
}
