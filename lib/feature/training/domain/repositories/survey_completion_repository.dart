import '../entities/survey_completion_entity.dart';

abstract class SurveyCompletionRepository {
  Future<SurveyCompletionEntity> getSurveyCompletion(String surveyId);
}
