import 'package:bloc/bloc.dart';
import '../../../domain/entities/lesson_entity.dart';
import '../../../domain/repositories/lesson_repository.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonRepository _lessonRepository;

  LessonBloc(this._lessonRepository) : super(LessonInitial()) {
    on<FetchLessons>(_onFetchLessons);
  }

  Future<void> _onFetchLessons(
    FetchLessons event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoading());
    try {
      final response = await _lessonRepository.getLessonsByModule(
        event.moduleId,
      );
      emit(LessonLoaded(response.lessons));
    } catch (e) {
      emit(LessonError(e.toString()));
    }
  }
}
