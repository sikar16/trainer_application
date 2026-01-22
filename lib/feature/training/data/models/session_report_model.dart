import 'package:equatable/equatable.dart';

class SessionReportModel extends Equatable {
  final String id;
  final String sessionId;
  final List<String> topicsCovered;
  final List<String> significantObservations;
  final double overallSatisfactionScore;
  final String learnerFeedbackSummary;
  final String positiveFeedback;
  final String areasForImprovement;
  final String specificFeedbackExamples;
  final double teachingMethodEffectiveness;
  final String trainerStrengths;
  final String trainerAreasForGrowth;
  final String trainerProfessionalGoals;
  final String curriculumRecommendations;
  final String deliveryMethodRecommendations;
  final String assessmentRecommendations;
  final String learnerSupportRecommendations;
  final String otherRecommendations;
  final String? remark;
  final List<dynamic> sessionReportFiles;

  const SessionReportModel({
    required this.id,
    required this.sessionId,
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
    this.remark,
    required this.sessionReportFiles,
  });

  factory SessionReportModel.fromJson(Map<String, dynamic> json) {
    return SessionReportModel(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      topicsCovered: List<String>.from(json['topicsCovered'] as List),
      significantObservations: List<String>.from(
        json['significantObservations'] as List,
      ),
      overallSatisfactionScore: (json['overallSatisfactionScore'] as num)
          .toDouble(),
      learnerFeedbackSummary: json['learnerFeedbackSummary'] as String,
      positiveFeedback: json['positiveFeedback'] as String,
      areasForImprovement: json['areasForImprovement'] as String,
      specificFeedbackExamples: json['specificFeedbackExamples'] as String,
      teachingMethodEffectiveness: (json['teachingMethodEffectiveness'] as num)
          .toDouble(),
      trainerStrengths: json['trainerStrengths'] as String,
      trainerAreasForGrowth: json['trainerAreasForGrowth'] as String,
      trainerProfessionalGoals: json['trainerProfessionalGoals'] as String,
      curriculumRecommendations: json['curriculumRecommendations'] as String,
      deliveryMethodRecommendations:
          json['deliveryMethodRecommendations'] as String,
      assessmentRecommendations: json['assessmentRecommendations'] as String,
      learnerSupportRecommendations:
          json['learnerSupportRecommendations'] as String,
      otherRecommendations: json['otherRecommendations'] as String,
      remark: json['remark'] as String?,
      sessionReportFiles: json['sessionReportFiles'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionId': sessionId,
      'topicsCovered': topicsCovered,
      'significantObservations': significantObservations,
      'overallSatisfactionScore': overallSatisfactionScore,
      'learnerFeedbackSummary': learnerFeedbackSummary,
      'positiveFeedback': positiveFeedback,
      'areasForImprovement': areasForImprovement,
      'specificFeedbackExamples': specificFeedbackExamples,
      'teachingMethodEffectiveness': teachingMethodEffectiveness,
      'trainerStrengths': trainerStrengths,
      'trainerAreasForGrowth': trainerAreasForGrowth,
      'trainerProfessionalGoals': trainerProfessionalGoals,
      'curriculumRecommendations': curriculumRecommendations,
      'deliveryMethodRecommendations': deliveryMethodRecommendations,
      'assessmentRecommendations': assessmentRecommendations,
      'learnerSupportRecommendations': learnerSupportRecommendations,
      'otherRecommendations': otherRecommendations,
      'remark': remark,
      'sessionReportFiles': sessionReportFiles,
    };
  }

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
