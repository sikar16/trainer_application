import '../../domain/entities/survey_completion_entity.dart';
import '../../domain/repositories/survey_completion_repository.dart';
import '../datasources/survey_completion_remote_data_source.dart';

class SurveyCompletionRepositoryImpl implements SurveyCompletionRepository {
  final SurveyCompletionRemoteDataSource remoteDataSource;

  SurveyCompletionRepositoryImpl(this.remoteDataSource);

  @override
  Future<SurveyCompletionEntity> getSurveyCompletion(String surveyId) {
    return remoteDataSource.getSurveyCompletion(surveyId);
  }
}
