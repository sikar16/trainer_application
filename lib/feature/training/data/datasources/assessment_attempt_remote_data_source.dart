import '../../../../core/network/api_client.dart';
import '../models/assessment_attempt_model.dart';

class AssessmentAttemptRemoteDataSource {
  final ApiClient apiClient;

  AssessmentAttemptRemoteDataSource({required this.apiClient});

  Future<AssessmentAttemptModel> getAssessmentAttempts(String assessmentId) async {
    try {
      final response = await apiClient.get(
        '/api/assessment-attempt/assessment/$assessmentId',
      );
      
      final data = response.data as Map<String, dynamic>;
      return AssessmentAttemptModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
