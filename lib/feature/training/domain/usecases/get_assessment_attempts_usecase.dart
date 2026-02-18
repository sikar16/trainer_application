import '../entities/assessment_attempt_entity.dart';
import '../repositories/assessment_attempt_repository.dart';

class GetAssessmentAttemptsUseCase {
  final AssessmentAttemptRepository _repository;

  GetAssessmentAttemptsUseCase(this._repository);

  Future<AssessmentAttemptEntity> call(String assessmentId) {
    return _repository.getAssessmentAttempts(assessmentId);
  }
}
