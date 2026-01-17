import '../entities/training_profile_entity.dart';

abstract class TrainingProfileRepository {
  Future<TrainingProfileResponseEntity> getTrainingProfile(String trainingId);
}
