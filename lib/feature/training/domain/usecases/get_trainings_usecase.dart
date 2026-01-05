import '../entities/training_entity.dart';
import '../repositories/training_repository.dart';

class GetTrainingsUseCase {
  final TrainingRepository repository;

  GetTrainingsUseCase(this.repository);

  Future<TrainingListEntity> call({int page = 1, int pageSize = 10}) {
    return repository.getTrainings(page: page, pageSize: pageSize);
  }
}
