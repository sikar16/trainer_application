import '../entities/training_profile_entity.dart';
import '../repositories/training_profile_repository.dart';

class GetTrainingProfileUseCase {
  final TrainingProfileRepository _repository;

  GetTrainingProfileUseCase(this._repository);

  Future<TrainingProfileResponseEntity> call(String trainingId) async {
    return await _repository.getTrainingProfile(trainingId);
  }
}
