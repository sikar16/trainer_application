import '../entities/application_entity.dart';

abstract class ApplicationRepository {
  Future<ApplicationResponseEntity> getMyApplications();
}
