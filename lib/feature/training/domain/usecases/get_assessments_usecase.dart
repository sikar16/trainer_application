import '../entities/assessment_entity.dart';
import '../repositories/assessment_repository.dart';

class GetAssessmentsUseCase {
  final AssessmentRepository _repository;

  GetAssessmentsUseCase(this._repository);

  Future<List<AssessmentEntity>> call(String trainingId) {
    return _repository.getAssessments(trainingId);
  }
}
