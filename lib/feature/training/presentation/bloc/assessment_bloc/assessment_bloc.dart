import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../core/network/api_client.dart';

import '../../../domain/entities/assessment_entity.dart';
import 'assessment_event.dart';
import 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final ApiClient _apiClient;

  AssessmentBloc({required ApiClient apiClient})
    : _apiClient = apiClient,
      super(AssessmentInitial()) {
    on<GetAssessmentsEvent>(_onGetAssessments);
  }

  Future<void> _onGetAssessments(
    GetAssessmentsEvent event,
    Emitter<AssessmentState> emit,
  ) async {
    emit(AssessmentLoading());
    try {
      final response = await _apiClient.get(
        '/api/assessment/training/${event.trainingId}',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final assessmentsList = data['assessments'] as List<dynamic>;

        final assessments = assessmentsList
            .map(
              (assessmentJson) => AssessmentEntity.fromJson(
                assessmentJson as Map<String, dynamic>,
              ),
            )
            .toList();

        emit(AssessmentLoaded(assessments));
      } else {
        emit(
          AssessmentError('Failed to load assessments: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      emit(AssessmentError('Failed to load assessments: ${e.message}'));
    } catch (e) {
      emit(AssessmentError('Failed to load assessments: $e'));
    }
  }
}
