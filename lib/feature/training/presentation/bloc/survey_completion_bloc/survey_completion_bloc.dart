import 'package:bloc/bloc.dart';
import '../../../domain/repositories/survey_completion_repository.dart';
import 'survey_completion_event.dart';
import 'survey_completion_state.dart';

class SurveyCompletionBloc
    extends Bloc<SurveyCompletionEvent, SurveyCompletionState> {
  final SurveyCompletionRepository _repository;

  SurveyCompletionBloc({required SurveyCompletionRepository repository})
    : _repository = repository,
      super(SurveyCompletionInitial()) {
    on<GetSurveyCompletionEvent>(_onGetSurveyCompletion);
    on<ClearSurveyCompletionEvent>(_onClearSurveyCompletion);
  }

  Future<void> _onGetSurveyCompletion(
    GetSurveyCompletionEvent event,
    Emitter<SurveyCompletionState> emit,
  ) async {
    emit(SurveyCompletionLoading());
    try {
      final surveyCompletion = await _repository.getSurveyCompletion(
        event.surveyId,
      );
      emit(SurveyCompletionLoaded(surveyCompletion.completedTraineeIds));
    } catch (e) {
      emit(SurveyCompletionError('Error loading survey completion data: $e'));
    }
  }

  void _onClearSurveyCompletion(
    ClearSurveyCompletionEvent event,
    Emitter<SurveyCompletionState> emit,
  ) {
    emit(SurveyCompletionInitial());
  }
}
