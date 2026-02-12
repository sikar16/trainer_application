import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../core/network/api_client.dart';

import '../../../domain/entities/survey_entity.dart';
import 'survey_event.dart';
import 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final ApiClient _apiClient;

  SurveyBloc({required ApiClient apiClient})
    : _apiClient = apiClient,
      super(SurveyInitial()) {
    on<GetSurveysEvent>(_onGetSurveys);
  }

  Future<void> _onGetSurveys(
    GetSurveysEvent event,
    Emitter<SurveyState> emit,
  ) async {
    emit(SurveyLoading());
    try {
      final response = await _apiClient.get(
        '/api/survey/training/${event.trainingId}',
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final surveysList = data['surveys'] as List<dynamic>;

        final surveys = surveysList
            .map(
              (surveyJson) =>
                  SurveyEntity.fromJson(surveyJson as Map<String, dynamic>),
            )
            .toList();

        emit(SurveyLoaded(surveys));
      } else {
        emit(SurveyError('Failed to load surveys: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      emit(SurveyError('Failed to load surveys: ${e.message}'));
    } catch (e) {
      emit(SurveyError('Failed to load surveys: $e'));
    }
  }
}
