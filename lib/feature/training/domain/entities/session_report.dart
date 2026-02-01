import 'package:equatable/equatable.dart';

class SessionReport extends Equatable {
  final List<String> topicsCovered;
  final List<String> significantObservations;
  final int overallSatisfactionScore;
  final String learnerFeedbackSummary;
  final String positiveFeedback;
  final String areasForImprovement;
  final String specificFeedbackExamples;
  final int teachingMethodEffectiveness;
  final String trainerStrengths;
  final String trainerAreasForGrowth;
  final String trainerProfessionalGoals;
  final String curriculumRecommendations;
  final String deliveryMethodRecommendations;
  final String assessmentRecommendations;
  final String learnerSupportRecommendations;
  final String otherRecommendations;
  final String remark;
  final List<SessionReportFile> sessionReportFiles;

  const SessionReport({
    required this.topicsCovered,
    required this.significantObservations,
    required this.overallSatisfactionScore,
    required this.learnerFeedbackSummary,
    required this.positiveFeedback,
    required this.areasForImprovement,
    required this.specificFeedbackExamples,
    required this.teachingMethodEffectiveness,
    required this.trainerStrengths,
    required this.trainerAreasForGrowth,
    required this.trainerProfessionalGoals,
    required this.curriculumRecommendations,
    required this.deliveryMethodRecommendations,
    required this.assessmentRecommendations,
    required this.learnerSupportRecommendations,
    required this.otherRecommendations,
    required this.remark,
    required this.sessionReportFiles,
  });

  @override
  List<Object?> get props => [
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

  const SessionReportFile({
    required this.reportFileTypeId,
    required this.file,
  });

  @override
  List<Object?> get props => [reportFileTypeId, file];
}
