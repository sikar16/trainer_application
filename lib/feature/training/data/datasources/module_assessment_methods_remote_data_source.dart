import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/module_detail_model.dart';

abstract class ModuleAssessmentMethodsRemoteDataSource {
  Future<ModuleAssessmentMethodsModel> getModuleAssessmentMethods(
    String moduleId,
  );
}

class ModuleAssessmentMethodsRemoteDataSourceImpl
    implements ModuleAssessmentMethodsRemoteDataSource {
  final ApiClient _apiClient;

  ModuleAssessmentMethodsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ModuleAssessmentMethodsModel> getModuleAssessmentMethods(
    String moduleId,
  ) async {
    try {
      final response = await _apiClient.get(
        '/api/module/assessment-method/$moduleId',
      );

      if (response.statusCode == 200) {
        return ModuleAssessmentMethodsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load module assessment methods');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
