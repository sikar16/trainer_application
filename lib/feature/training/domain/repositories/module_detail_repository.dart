import '../entities/module_detail_entity.dart';

abstract class ModuleDetailRepository {
  Future<ModuleProfileEntity> getModuleDetail(String moduleId);
}
