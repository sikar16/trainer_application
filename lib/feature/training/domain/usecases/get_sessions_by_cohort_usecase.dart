import '../entities/session_entity.dart';
import '../repositories/session_repository.dart';

class GetSessionsByCohortUseCase {
  final SessionRepository repository;

  GetSessionsByCohortUseCase(this.repository);

  Future<SessionListEntity> call({
    required String cohortId,
    int page = 1,
    int pageSize = 20,
  }) {
    return repository.getSessionsByCohort(
      cohortId: cohortId,
      page: page,
      pageSize: pageSize,
    );
  }
}
