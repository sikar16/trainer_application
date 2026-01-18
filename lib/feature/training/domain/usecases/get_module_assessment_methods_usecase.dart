import '../entities/module_detail_entity.dart';
import '../repositories/module_assessment_methods_repository.dart';

class GetModuleAssessmentMethodsUseCase {
  final ModuleAssessmentMethodsRepository _repository;

  GetModuleAssessmentMethodsUseCase(this._repository);

  Future<ModuleAssessmentMethodsEntity> call(String moduleId) async {
    return await _repository.getModuleAssessmentMethods(moduleId);
  }
}
