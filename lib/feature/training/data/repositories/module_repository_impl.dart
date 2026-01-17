import '../../domain/repositories/module_repository.dart';
import '../datasources/module_remote_data_source.dart';
import '../../domain/entities/module_entity.dart';

class ModuleRepositoryImpl implements ModuleRepository {
  final ModuleRemoteDataSource _remoteDataSource;

  ModuleRepositoryImpl(this._remoteDataSource);

  @override
  Future<ModuleResponseEntity> getModules(String trainingId) async {
    final moduleModel = await _remoteDataSource.getModules(trainingId);
    return moduleModel.toEntity();
  }
}
