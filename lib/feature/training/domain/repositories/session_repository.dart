import '../entities/session_entity.dart';

abstract class SessionRepository {
  Future<SessionListEntity> getSessionsByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 20,
  });
}
