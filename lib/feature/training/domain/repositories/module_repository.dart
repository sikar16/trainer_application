import '../../data/datasources/module_remote_data_source.dart';
import '../../domain/entities/module_entity.dart';

abstract class ModuleRepository {
  Future<ModuleResponseEntity> getModules(String trainingId);
}
