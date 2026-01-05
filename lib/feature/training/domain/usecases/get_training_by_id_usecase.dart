import '../entities/training_entity.dart';
import '../repositories/training_repository.dart';

class GetTrainingByIdUseCase {
  final TrainingRepository repository;

  GetTrainingByIdUseCase(this.repository);

  Future<TrainingEntity> call(String id) {
    return repository.getTrainingById(id);
  }
}

