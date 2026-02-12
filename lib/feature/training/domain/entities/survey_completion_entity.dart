import 'package:equatable/equatable.dart';

class SurveyCompletionEntity extends Equatable {
  final String surveyId;
  final String code;
  final List<TraineeCompletionEntity> trainees;
  final int count;
  final String message;

  const SurveyCompletionEntity({
    required this.surveyId,
    required this.code,
    required this.trainees,
    required this.count,
    required this.message,
  });

  @override
  List<Object?> get props => [surveyId, code, trainees, count, message];

  List<String> get completedTraineeIds {
    return trainees.map((trainee) => trainee.id).toList();
  }
}

class TraineeCompletionEntity extends Equatable {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String contactPhone;

  const TraineeCompletionEntity({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.contactPhone,
  });

  @override
  List<Object?> get props => [id, firstName, middleName, lastName, email, contactPhone];
}
