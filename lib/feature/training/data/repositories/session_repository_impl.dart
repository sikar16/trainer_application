import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_remote_data_source.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRepositoryImpl(this.remoteDataSource);

  @override
  Future<SessionListEntity> getSessionsByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 20,
  }) {
    return remoteDataSource.getSessionsByCohort(
      cohortId: cohortId,
      page: page,
      pageSize: pageSize,
    );
  }
}
