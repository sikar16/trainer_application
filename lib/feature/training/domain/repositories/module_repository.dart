import '../../domain/entities/module_entity.dart';

abstract class ModuleRepository {
  Future<ModuleResponseEntity> getModules(String trainingId);
}
