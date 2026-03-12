import '../../domain/entities/lesson_entity.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../datasources/lesson_remote_data_source.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonRemoteDataSource _lessonRemoteDataSource;

  LessonRepositoryImpl(this._lessonRemoteDataSource);

  @override
  Future<LessonResponseEntity> getLessonsByModule(String moduleId) async {
    try {
      final lessonModels = await _lessonRemoteDataSource.getLessonsByModule(
        moduleId,
      );
      return LessonResponseEntity(
        code: 'OK',
        message: '',
        lessons: lessonModels.map((model) => model.toEntity()).toList(),
      );
    } catch (e) {
      throw Exception('Failed to get lessons: $e');
    }
  }
}
