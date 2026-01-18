import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/module_detail_model.dart';

abstract class ModuleDetailRemoteDataSource {
  Future<ModuleProfileModel> getModuleDetail(String moduleId);
}

class ModuleDetailRemoteDataSourceImpl implements ModuleDetailRemoteDataSource {
  final ApiClient _apiClient;

  ModuleDetailRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ModuleProfileModel> getModuleDetail(String moduleId) async {
    try {
      final response = await _apiClient.get('/api/module/profile/$moduleId');

      if (response.statusCode == 200) {
        return ModuleProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load module detail');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
