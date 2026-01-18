import '../entities/module_detail_entity.dart';
import '../repositories/module_detail_repository.dart';

class GetModuleDetailUseCase {
  final ModuleDetailRepository _repository;

  GetModuleDetailUseCase(this._repository);

  Future<ModuleProfileEntity> call(String moduleId) async {
    return await _repository.getModuleDetail(moduleId);
  }
}
