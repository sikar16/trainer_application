import '../entities/lesson_entity.dart';

abstract class LessonRepository {
  Future<LessonResponseEntity> getLessonsByModule(String moduleId);
}
