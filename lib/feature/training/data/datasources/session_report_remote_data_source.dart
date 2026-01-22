import '../../../../core/network/api_client.dart';
import '../models/session_report_model.dart';

class SessionReportRemoteDataSource {
  final ApiClient _apiClient;

  SessionReportRemoteDataSource(this._apiClient);

  Future<SessionReportModel> getSessionReport(String sessionId) async {
    try {
      final response = await _apiClient.get('/api/session/$sessionId/report');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['code'] == 'OK' && data['report'] != null) {
          return SessionReportModel.fromJson(data['report']);
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch session report');
        }
      } else {
        throw Exception(
          'Failed to fetch session report: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching session report: $e');
    }
  }
}
