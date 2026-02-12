import 'package:equatable/equatable.dart';

abstract class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => [];
}

class GetSurveysEvent extends SurveyEvent {
  final String trainingId;

  const GetSurveysEvent({required this.trainingId});

  @override
  List<Object> get props => [trainingId];
}
