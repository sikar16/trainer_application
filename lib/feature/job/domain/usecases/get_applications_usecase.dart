import '../entities/application_entity.dart';
import '../repositories/application_repository.dart';

class GetApplicationsUseCase {
  final ApplicationRepository _repository;

  GetApplicationsUseCase(this._repository);

  Future<ApplicationResponseEntity> call() async {
    return await _repository.getMyApplications();
  }
}
