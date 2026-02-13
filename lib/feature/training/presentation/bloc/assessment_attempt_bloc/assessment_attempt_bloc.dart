import 'package:bloc/bloc.dart';
import '../../../domain/repositories/assessment_attempt_repository.dart';
import 'assessment_attempt_event.dart';
import 'assessment_attempt_state.dart';

class AssessmentAttemptBloc
    extends Bloc<AssessmentAttemptEvent, AssessmentAttemptState> {
  final AssessmentAttemptRepository _repository;

  AssessmentAttemptBloc({required AssessmentAttemptRepository repository})
    : _repository = repository,
      super(AssessmentAttemptInitial()) {
    on<GetAssessmentAttemptsEvent>(_onGetAssessmentAttempts);
    on<ClearAssessmentAttemptsEvent>(_onClearAssessmentAttempts);
  }

  Future<void> _onGetAssessmentAttempts(
    GetAssessmentAttemptsEvent event,
    Emitter<AssessmentAttemptState> emit,
  ) async {
    emit(AssessmentAttemptLoading());
    try {
      final assessmentAttempt = await _repository.getAssessmentAttempts(event.assessmentId);
      emit(AssessmentAttemptLoaded(assessmentAttempt));
    } catch (e) {
      emit(AssessmentAttemptError('Error loading assessment attempts: $e'));
    }
  }

  void _onClearAssessmentAttempts(
    ClearAssessmentAttemptsEvent event,
    Emitter<AssessmentAttemptState> emit,
  ) {
    emit(AssessmentAttemptInitial());
  }
}
