import '../../../../core/network/api_client.dart';
import '../models/audience_profile_model.dart';

abstract class AudienceProfileRemoteDataSource {
  Future<AudienceProfileModel> getAudienceProfile(String trainingId);
}

class AudienceProfileRemoteDataSourceImpl
    implements AudienceProfileRemoteDataSource {
  final ApiClient _apiClient;

  AudienceProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AudienceProfileModel> getAudienceProfile(String trainingId) async {
    try {
      final response = await _apiClient.get(
        '/api/training/audience-profile/$trainingId',
      );

      if (response.statusCode == 200) {
        return AudienceProfileModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load audience profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load audience profile: $e');
    }
  }
}
