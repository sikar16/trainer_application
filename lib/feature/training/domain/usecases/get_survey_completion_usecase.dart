import '../entities/survey_completion_entity.dart';
import '../repositories/survey_completion_repository.dart';

class GetSurveyCompletionUseCase {
  final SurveyCompletionRepository _repository;

  GetSurveyCompletionUseCase(this._repository);

  Future<SurveyCompletionEntity> call(String surveyId) {
    return _repository.getSurveyCompletion(surveyId);
  }
}
