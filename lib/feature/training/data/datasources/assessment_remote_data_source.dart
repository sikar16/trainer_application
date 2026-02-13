import '../../../../core/network/api_client.dart';
import '../models/assessment_model.dart';

class AssessmentRemoteDataSource {
  final ApiClient apiClient;

  AssessmentRemoteDataSource({required this.apiClient});

  Future<List<AssessmentModel>> getAssessments(String trainingId) async {
    try {
      final response = await apiClient.get(
        '/api/assessment/training/$trainingId',
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final assessmentsList = data['assessments'] as List<dynamic>;
        
        return assessmentsList
            .map((assessmentJson) => AssessmentModel.fromJson(
              assessmentJson as Map<String, dynamic>,
            ))
            .toList();
      } else {
        throw Exception('Failed to load assessments: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
