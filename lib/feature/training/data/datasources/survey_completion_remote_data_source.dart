import '../../../../core/network/api_client.dart';
import '../models/survey_completion_model.dart';

class SurveyCompletionRemoteDataSource {
  final ApiClient apiClient;

  SurveyCompletionRemoteDataSource({required this.apiClient});

  Future<SurveyCompletionModel> getSurveyCompletion(String surveyId) async {
    try {
      final response = await apiClient.get(
        '/api/survey/$surveyId/answered-trainees',
      );
      
      final data = response.data as Map<String, dynamic>;
      return SurveyCompletionModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
