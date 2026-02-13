import 'package:equatable/equatable.dart';

class AssessmentAttemptEntity extends Equatable {
  final String code;
  final int count;
  final List<TraineeAttemptEntity> traineeAttempts;
  final String message;

  const AssessmentAttemptEntity({
    required this.code,
    required this.count,
    required this.traineeAttempts,
    required this.message,
  });

  @override
  List<Object?> get props => [code, count, traineeAttempts, message];

  Map<String, TraineeAttemptEntity> get traineeAttemptsMap {
    final Map<String, TraineeAttemptEntity> attemptsMap = {};
    for (final attempt in traineeAttempts) {
      attemptsMap[attempt.traineeId] = attempt;
    }
    return attemptsMap;
  }
}

class TraineeAttemptEntity extends Equatable {
  final String traineeId;
  final String traineeName;
  final String traineeEmail;
  final String traineeContactPhone;
  final int totalAttempts;
  final double? preAssessmentScore;
  final double? postAssessmentScore;
  final bool? hasPassed;

  const TraineeAttemptEntity({
    required this.traineeId,
    required this.traineeName,
    required this.traineeEmail,
    required this.traineeContactPhone,
    required this.totalAttempts,
    this.preAssessmentScore,
    this.postAssessmentScore,
    this.hasPassed,
  });

  @override
  List<Object?> get props => [
    traineeId,
    traineeName,
    traineeEmail,
    traineeContactPhone,
    totalAttempts,
    preAssessmentScore,
    postAssessmentScore,
    hasPassed,
  ];

  String get preAssessmentDisplay {
    if (preAssessmentScore == null) return "Not taken";
    return "${preAssessmentScore!.toStringAsFixed(2)}%";
  }

  String get postAssessmentDisplay {
    if (postAssessmentScore == null)
      return "Not taken ($totalAttempts attempts)";
    return "${postAssessmentScore!.toStringAsFixed(2)}%";
  }

  String get attemptsDisplay {
    return "$totalAttempts attempt${totalAttempts == 1 ? '' : 's'}";
  }
}
