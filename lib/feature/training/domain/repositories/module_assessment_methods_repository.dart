import '../entities/module_detail_entity.dart';

abstract class ModuleAssessmentMethodsRepository {
  Future<ModuleAssessmentMethodsEntity> getModuleAssessmentMethods(
    String moduleId,
  );
}
