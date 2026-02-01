import '../entities/session_report.dart';

abstract class SessionReportRepository {
  Future<SessionReport?> getSessionReport(String sessionId);
  Future<SessionReport?> createSessionReport(
    String sessionId,
    Map<String, dynamic> reportData,
  );
}
