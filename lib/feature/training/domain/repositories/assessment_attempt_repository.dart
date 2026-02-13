import '../entities/assessment_attempt_entity.dart';

abstract class AssessmentAttemptRepository {
  Future<AssessmentAttemptEntity> getAssessmentAttempts(String assessmentId);
}
