import '../../domain/entities/module_detail_entity.dart';
import '../../domain/repositories/module_assessment_methods_repository.dart';
import '../datasources/module_assessment_methods_remote_data_source.dart';

class ModuleAssessmentMethodsRepositoryImpl
    implements ModuleAssessmentMethodsRepository {
  final ModuleAssessmentMethodsRemoteDataSource _remoteDataSource;

  ModuleAssessmentMethodsRepositoryImpl(this._remoteDataSource);

  @override
  Future<ModuleAssessmentMethodsEntity> getModuleAssessmentMethods(
    String moduleId,
  ) async {
    try {
      final assessmentMethods = await _remoteDataSource
          .getModuleAssessmentMethods(moduleId);
      return assessmentMethods.toEntity();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
