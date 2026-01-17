import '../../../../core/network/api_client.dart';
import '../models/module_model.dart';

abstract class ModuleRemoteDataSource {
  Future<ModuleResponseModel> getModules(String trainingId);
}

class ModuleRemoteDataSourceImpl implements ModuleRemoteDataSource {
  final ApiClient _apiClient;

  ModuleRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ModuleResponseModel> getModules(String trainingId) async {
    final response = await _apiClient.get(
      '/api/module/training/$trainingId?include-all=false',
    );

    if (response.statusCode == 200) {
      return ModuleResponseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load modules: ${response.statusCode}');
    }
  }
}
