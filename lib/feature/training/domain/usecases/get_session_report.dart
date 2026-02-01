import '../entities/session_report.dart';
import '../repositories/session_report_repository.dart';

class GetSessionReport {
  final SessionReportRepository repository;

  GetSessionReport(this.repository);

  Future<SessionReport?> call(String sessionId) async {
    return await repository.getSessionReport(sessionId);
  }
}
