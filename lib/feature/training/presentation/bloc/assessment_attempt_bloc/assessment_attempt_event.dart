import 'package:equatable/equatable.dart';

abstract class AssessmentAttemptEvent extends Equatable {
  const AssessmentAttemptEvent();

  @override
  List<Object> get props => [];
}

class GetAssessmentAttemptsEvent extends AssessmentAttemptEvent {
  final String assessmentId;

  const GetAssessmentAttemptsEvent({required this.assessmentId});

  @override
  List<Object> get props => [assessmentId];
}

class ClearAssessmentAttemptsEvent extends AssessmentAttemptEvent {
  const ClearAssessmentAttemptsEvent();
}
