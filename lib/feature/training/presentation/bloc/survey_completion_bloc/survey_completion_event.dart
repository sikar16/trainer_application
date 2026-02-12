import 'package:equatable/equatable.dart';

abstract class SurveyCompletionEvent extends Equatable {
  const SurveyCompletionEvent();

  @override
  List<Object> get props => [];
}

class GetSurveyCompletionEvent extends SurveyCompletionEvent {
  final String surveyId;

  const GetSurveyCompletionEvent({required this.surveyId});

  @override
  List<Object> get props => [surveyId];
}

class ClearSurveyCompletionEvent extends SurveyCompletionEvent {
  const ClearSurveyCompletionEvent();
}
