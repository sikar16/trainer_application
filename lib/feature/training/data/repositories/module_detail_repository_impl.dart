import '../../domain/entities/module_detail_entity.dart';
import '../../domain/repositories/module_detail_repository.dart';
import '../datasources/module_detail_remote_data_source.dart';

class ModuleDetailRepositoryImpl implements ModuleDetailRepository {
  final ModuleDetailRemoteDataSource _remoteDataSource;

  ModuleDetailRepositoryImpl(this._remoteDataSource);

  @override
  Future<ModuleProfileEntity> getModuleDetail(String moduleId) async {
    try {
      final moduleProfile = await _remoteDataSource.getModuleDetail(moduleId);
      return moduleProfile.toEntity();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
