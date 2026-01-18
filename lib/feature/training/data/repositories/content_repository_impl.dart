import '../datasources/content_remote_data_source.dart';
import '../../domain/entities/content_entity.dart';
import '../../domain/repositories/content_repository.dart';

class ContentRepositoryImpl implements ContentRepository {
  final ContentRemoteDataSource _remoteDataSource;

  ContentRepositoryImpl(this._remoteDataSource);

  @override
  Future<ContentResponseEntity> getContents({
    required String trainingId,
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async {
    try {
      final contentResponse = await _remoteDataSource.getContents(
        trainingId: trainingId,
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
      );
      return contentResponse.toEntity();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
