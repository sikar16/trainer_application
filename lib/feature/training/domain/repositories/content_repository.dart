import '../entities/content_entity.dart';

abstract class ContentRepository {
  Future<ContentResponseEntity> getContents({
    required String trainingId,
    required int page,
    required int pageSize,
    String? searchQuery,
  });
}
