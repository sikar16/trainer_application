import 'package:equatable/equatable.dart';
import '../../../domain/entities/assessment_entity.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentLoaded extends AssessmentState {
  final List<AssessmentEntity> assessments;

  const AssessmentLoaded(this.assessments);

  @override
  List<Object> get props => [assessments];
}

class AssessmentError extends AssessmentState {
  final String message;

  const AssessmentError(this.message);

  @override
  List<Object> get props => [message];
}
