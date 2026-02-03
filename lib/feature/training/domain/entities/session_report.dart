import 'package:equatable/equatable.dart';

class SessionReport extends Equatable {
  final String id;
  final String sessionId;
  final List<String> topicsCovered;
  final List<String> significantObservations;
  final int? overallSatisfactionScore;
  final String? learnerFeedbackSummary;
  final String? positiveFeedback;
  final String? areasForImprovement;
  final String? specificFeedbackExamples;
  final int? teachingMethodEffectiveness;
  final String? trainerStrengths;
  final String? trainerAreasForGrowth;
  final String? trainerProfessionalGoals;
  final String? curriculumRecommendations;
  final String? deliveryMethodRecommendations;
  final String? assessmentRecommendations;
  final String? learnerSupportRecommendations;
  final String? otherRecommendations;
  final String? remark;
  final List<SessionReportFile> sessionReportFiles;

  const SessionReport({
    required this.id,
    required this.sessionId,
    required this.topicsCovered,
    required this.significantObservations,
    this.overallSatisfactionScore,
    this.learnerFeedbackSummary,
    this.positiveFeedback,
    this.areasForImprovement,
    this.specificFeedbackExamples,
    this.teachingMethodEffectiveness,
    this.trainerStrengths,
    this.trainerAreasForGrowth,
    this.trainerProfessionalGoals,
    this.curriculumRecommendations,
    this.deliveryMethodRecommendations,
    this.assessmentRecommendations,
    this.learnerSupportRecommendations,
    this.otherRecommendations,
    this.remark,
    required this.sessionReportFiles,
  });

  @override
  List<Object?> get props => [
    id,
    sessionId,
    topicsCovered,
    significantObservations,
    overallSatisfactionScore,
    learnerFeedbackSummary,
    positiveFeedback,
    areasForImprovement,
    specificFeedbackExamples,
    teachingMethodEffectiveness,
    trainerStrengths,
    trainerAreasForGrowth,
    trainerProfessionalGoals,
    curriculumRecommendations,
    deliveryMethodRecommendations,
    assessmentRecommendations,
    learnerSupportRecommendations,
    otherRecommendations,
    remark,
    sessionReportFiles,
  ];
}

class SessionReportFile extends Equatable {
  final String reportFileTypeId;
  final String file;

  const SessionReportFile({required this.reportFileTypeId, required this.file});

  @override
  List<Object?> get props => [reportFileTypeId, file];
}
