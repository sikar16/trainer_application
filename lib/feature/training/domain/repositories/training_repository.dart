import '../entities/training_entity.dart';

abstract class TrainingRepository {
  Future<TrainingListEntity> getTrainings({int page, int pageSize});
  Future<TrainingEntity> getTrainingById(String id);
}
