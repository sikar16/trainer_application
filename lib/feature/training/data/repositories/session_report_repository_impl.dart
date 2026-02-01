import '../datasources/session_report_remote_data_source.dart';
import '../../domain/entities/session_report.dart';
import '../../domain/repositories/session_report_repository.dart';

class SessionReportRepositoryImpl implements SessionReportRepository {
  final SessionReportRemoteDataSource remoteDataSource;

  SessionReportRepositoryImpl(this.remoteDataSource);

  @override
  Future<SessionReport?> getSessionReport(String sessionId) async {
    try {
      final reportModel = await remoteDataSource.getSessionReport(sessionId);
      return SessionReport(
        topicsCovered: reportModel.topicsCovered,
        significantObservations: reportModel.significantObservations,
        overallSatisfactionScore: reportModel.overallSatisfactionScore.round(),
        learnerFeedbackSummary: reportModel.learnerFeedbackSummary,
        positiveFeedback: reportModel.positiveFeedback,
        areasForImprovement: reportModel.areasForImprovement,
        specificFeedbackExamples: reportModel.specificFeedbackExamples,
        teachingMethodEffectiveness: reportModel.teachingMethodEffectiveness
            .round(),
        trainerStrengths: reportModel.trainerStrengths,
        trainerAreasForGrowth: reportModel.trainerAreasForGrowth,
        trainerProfessionalGoals: reportModel.trainerProfessionalGoals,
        curriculumRecommendations: reportModel.curriculumRecommendations,
        deliveryMethodRecommendations:
            reportModel.deliveryMethodRecommendations,
        assessmentRecommendations: reportModel.assessmentRecommendations,
        learnerSupportRecommendations:
            reportModel.learnerSupportRecommendations,
        otherRecommendations: reportModel.otherRecommendations,
        remark: reportModel.remark ?? '',
        sessionReportFiles: reportModel.sessionReportFiles
            .map(
              (file) => SessionReportFile(
                reportFileTypeId: file['reportFileTypeId']?.toString() ?? '',
                file: file['file']?.toString() ?? '',
              ),
            )
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<SessionReport?> createSessionReport(
    String sessionId,
    Map<String, dynamic> reportData,
  ) async {
    try {
      final reportModel = await remoteDataSource.createSessionReport(
        sessionId,
        reportData,
      );
      return SessionReport(
        topicsCovered: reportModel.topicsCovered,
        significantObservations: reportModel.significantObservations,
        overallSatisfactionScore: reportModel.overallSatisfactionScore.round(),
        learnerFeedbackSummary: reportModel.learnerFeedbackSummary,
        positiveFeedback: reportModel.positiveFeedback,
        areasForImprovement: reportModel.areasForImprovement,
        specificFeedbackExamples: reportModel.specificFeedbackExamples,
        teachingMethodEffectiveness: reportModel.teachingMethodEffectiveness
            .round(),
        trainerStrengths: reportModel.trainerStrengths,
        trainerAreasForGrowth: reportModel.trainerAreasForGrowth,
        trainerProfessionalGoals: reportModel.trainerProfessionalGoals,
        curriculumRecommendations: reportModel.curriculumRecommendations,
        deliveryMethodRecommendations:
            reportModel.deliveryMethodRecommendations,
        assessmentRecommendations: reportModel.assessmentRecommendations,
        learnerSupportRecommendations:
            reportModel.learnerSupportRecommendations,
        otherRecommendations: reportModel.otherRecommendations,
        remark: reportModel.remark ?? '',
        sessionReportFiles: reportModel.sessionReportFiles
            .map(
              (file) => SessionReportFile(
                reportFileTypeId: file['reportFileTypeId']?.toString() ?? '',
                file: file['file']?.toString() ?? '',
              ),
            )
            .toList(),
      );
    } catch (e) {
      return null;
    }
  }
}
