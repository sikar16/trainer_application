import 'package:equatable/equatable.dart';
import '../../../domain/entities/assessment_attempt_entity.dart';

abstract class AssessmentAttemptState extends Equatable {
  const AssessmentAttemptState();

  @override
  List<Object> get props => [];
}

class AssessmentAttemptInitial extends AssessmentAttemptState {
  const AssessmentAttemptInitial();
}

class AssessmentAttemptLoading extends AssessmentAttemptState {
  const AssessmentAttemptLoading();
}

class AssessmentAttemptLoaded extends AssessmentAttemptState {
  final AssessmentAttemptEntity assessmentAttempt;

  const AssessmentAttemptLoaded(this.assessmentAttempt);

  @override
  List<Object> get props => [assessmentAttempt];
}

class AssessmentAttemptError extends AssessmentAttemptState {
  final String message;

  const AssessmentAttemptError(this.message);

  @override
  List<Object> get props => [message];
}
