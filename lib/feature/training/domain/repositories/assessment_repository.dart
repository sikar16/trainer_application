import '../entities/assessment_entity.dart';

abstract class AssessmentRepository {
  Future<List<AssessmentEntity>> getAssessments(String trainingId);
}
