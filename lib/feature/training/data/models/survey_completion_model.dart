import '../../domain/entities/survey_completion_entity.dart';

class SurveyCompletionModel extends SurveyCompletionEntity {
  const SurveyCompletionModel({
    required super.surveyId,
    required super.code,
    required super.trainees,
    required super.count,
    required super.message,
  });

  factory SurveyCompletionModel.fromJson(Map<String, dynamic> json) {
    return SurveyCompletionModel(
      surveyId: json['surveyId'] as String,
      code: json['code'] as String,
      trainees: (json['trainees'] as List<dynamic>)
          .map((trainee) => TraineeCompletionModel.fromJson(trainee as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyId': surveyId,
      'code': code,
      'trainees': trainees.map((trainee) => (trainee as TraineeCompletionModel).toJson()).toList(),
      'count': count,
      'message': message,
    };
  }
}

class TraineeCompletionModel extends TraineeCompletionEntity {
  const TraineeCompletionModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required super.contactPhone,
  });

  factory TraineeCompletionModel.fromJson(Map<String, dynamic> json) {
    return TraineeCompletionModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      contactPhone: json['contactPhone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      if (middleName != null) 'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'contactPhone': contactPhone,
    };
  }
}
