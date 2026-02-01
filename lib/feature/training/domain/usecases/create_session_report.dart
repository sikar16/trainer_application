import '../entities/session_report.dart';
import '../repositories/session_report_repository.dart';

class CreateSessionReport {
  final SessionReportRepository repository;

  CreateSessionReport(this.repository);

  Future<SessionReport?> call(String sessionId, Map<String, dynamic> reportData) async {
    return await repository.createSessionReport(sessionId, reportData);
  }
}
