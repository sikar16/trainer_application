import 'package:equatable/equatable.dart';

abstract class SurveyCompletionState extends Equatable {
  const SurveyCompletionState();

  @override
  List<Object> get props => [];
}

class SurveyCompletionInitial extends SurveyCompletionState {
  const SurveyCompletionInitial();
}

class SurveyCompletionLoading extends SurveyCompletionState {
  const SurveyCompletionLoading();
}

class SurveyCompletionLoaded extends SurveyCompletionState {
  final List<String> completedTraineeIds;

  const SurveyCompletionLoaded(this.completedTraineeIds);

  @override
  List<Object> get props => [completedTraineeIds];
}

class SurveyCompletionError extends SurveyCompletionState {
  final String message;

  const SurveyCompletionError(this.message);

  @override
  List<Object> get props => [message];
}
