import '../../domain/entities/application_entity.dart';
import '../../domain/repositories/application_repository.dart';
import '../datasources/application_remote_data_source.dart';
import '../models/application_model.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource _remoteDataSource;

  ApplicationRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApplicationResponseEntity> getMyApplications() async {
    try {
      final ApplicationModel applicationModel = await _remoteDataSource.getMyApplications();
      return ApplicationResponseEntity(
        applications: applicationModel.applications,
        totalPages: applicationModel.totalPages,
        totalElements: applicationModel.totalElements,
        code: applicationModel.code,
        message: applicationModel.message,
      );
    } catch (e) {
      throw Exception('Failed to get applications: $e');
    }
  }
}
