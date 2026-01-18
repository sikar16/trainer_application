import '../entities/content_entity.dart';
import '../repositories/content_repository.dart';

class GetContentUseCase {
  final ContentRepository _repository;

  GetContentUseCase(this._repository);

  Future<ContentResponseEntity> call({
    required String trainingId,
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async {
    return await _repository.getContents(
      trainingId: trainingId,
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
    );
  }
}
