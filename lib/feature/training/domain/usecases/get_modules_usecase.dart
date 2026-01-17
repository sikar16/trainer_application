import '../repositories/module_repository.dart';
import '../entities/module_entity.dart';

class GetModulesUseCase {
  final ModuleRepository _repository;

  GetModulesUseCase(this._repository);

  Future<ModuleResponseEntity> call(String trainingId) async {
    return await _repository.getModules(trainingId);
  }
}
