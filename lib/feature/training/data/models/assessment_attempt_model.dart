import '../../domain/entities/assessment_attempt_entity.dart';

class AssessmentAttemptModel extends AssessmentAttemptEntity {
  const AssessmentAttemptModel({
    required super.code,
    required super.count,
    required super.traineeAttempts,
    required super.message,
  });

  factory AssessmentAttemptModel.fromJson(Map<String, dynamic> json) {
    return AssessmentAttemptModel(
      code: json['code'] as String,
      count: json['count'] as int,
      traineeAttempts: (json['traineeAttempts'] as List<dynamic>)
          .map((attempt) => TraineeAttemptModel.fromJson(attempt as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'count': count,
      'traineeAttempts': traineeAttempts.map((attempt) => (attempt as TraineeAttemptModel).toJson()).toList(),
      'message': message,
    };
  }
}

class TraineeAttemptModel extends TraineeAttemptEntity {
  const TraineeAttemptModel({
    required super.traineeId,
    required super.traineeName,
    required super.traineeEmail,
    required super.traineeContactPhone,
    required super.totalAttempts,
    super.preAssessmentScore,
    super.postAssessmentScore,
    super.hasPassed,
  });

  factory TraineeAttemptModel.fromJson(Map<String, dynamic> json) {
    return TraineeAttemptModel(
      traineeId: json['traineeId'] as String,
      traineeName: json['traineeName'] as String,
      traineeEmail: json['traineeEmail'] as String,
      traineeContactPhone: json['traineeContactPhone'] as String,
      totalAttempts: json['totalAttempts'] as int,
      preAssessmentScore: json['preAssessmentScore'] as double?,
      postAssessmentScore: json['postAssessmentScore'] as double?,
      hasPassed: json['hasPassed'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'traineeId': traineeId,
      'traineeName': traineeName,
      'traineeEmail': traineeEmail,
      'traineeContactPhone': traineeContactPhone,
      'totalAttempts': totalAttempts,
      if (preAssessmentScore != null) 'preAssessmentScore': preAssessmentScore,
      if (postAssessmentScore != null) 'postAssessmentScore': postAssessmentScore,
      if (hasPassed != null) 'hasPassed': hasPassed,
    };
  }
}
