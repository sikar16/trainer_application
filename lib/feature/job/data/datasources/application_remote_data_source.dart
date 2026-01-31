import '../../../../core/network/api_client.dart';
import '../models/application_model.dart';

abstract class ApplicationRemoteDataSource {
  Future<ApplicationModel> getMyApplications();
}

class ApplicationRemoteDataSourceImpl implements ApplicationRemoteDataSource {
  final ApiClient _apiClient;

  ApplicationRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApplicationModel> getMyApplications() async {
    try {
      const String url = '/api/application/me';

      final response = await _apiClient.get(url);

      if (response.statusCode == 200) {
        return ApplicationModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load applications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load applications: $e');
    }
  }
}
