import '../../../../core/network/api_client.dart';
import '../models/training_profile_model.dart';

abstract class TrainingProfileRemoteDataSource {
  Future<TrainingProfileModel> getTrainingProfile(String trainingId);
}

class TrainingProfileRemoteDataSourceImpl
    implements TrainingProfileRemoteDataSource {
  final ApiClient _apiClient;

  TrainingProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<TrainingProfileModel> getTrainingProfile(String trainingId) async {
    try {
      final response = await _apiClient.get(
        '/api/training/training-profile/$trainingId',
      );

      if (response.statusCode == 200) {
        return TrainingProfileModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load training profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load training profile: $e');
    }
  }
}
