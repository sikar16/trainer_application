import 'package:equatable/equatable.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object> get props => [];
}

class GetAssessmentsEvent extends AssessmentEvent {
  final String trainingId;

  const GetAssessmentsEvent({required this.trainingId});

  @override
  List<Object> get props => [trainingId];
}
