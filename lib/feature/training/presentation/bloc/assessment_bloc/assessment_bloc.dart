import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../domain/repositories/assessment_repository.dart';
import 'assessment_event.dart';
import 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository _assessmentRepository;

  AssessmentBloc({required AssessmentRepository assessmentRepository})
    : _assessmentRepository = assessmentRepository,
      super(AssessmentInitial()) {
    on<GetAssessmentsEvent>(_onGetAssessments);
  }

  Future<void> _onGetAssessments(
    GetAssessmentsEvent event,
    Emitter<AssessmentState> emit,
  ) async {
    emit(AssessmentLoading());
    try {
      final assessments = await _assessmentRepository.getAssessments(
        event.trainingId,
      );
      emit(AssessmentLoaded(assessments));
    } on DioException catch (e) {
      emit(AssessmentError('Failed to load assessments: ${e.message}'));
    } catch (e) {
      emit(AssessmentError('Failed to load assessments: $e'));
    }
  }
}
