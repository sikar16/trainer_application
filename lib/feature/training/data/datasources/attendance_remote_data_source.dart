import '../../../../core/network/api_client.dart';
import '../models/attendance_model.dart';

class AttendanceRemoteDataSource {
  final ApiClient apiClient;

  AttendanceRemoteDataSource({required this.apiClient});

  Future<AttendanceListModel> getAttendanceBySession(String sessionId) async {
    try {
      final response = await apiClient.get(
        '/api/attendance/session/$sessionId',
      );
      final data = response.data;

      return AttendanceListModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceModel> saveAttendance({
    required String sessionId,
    required String traineeId,
    required bool isPresent,
    String comment = '',
  }) async {
    try {
      final response = await apiClient.post(
        '/api/attendance',
        data: {
          'sessionId': sessionId,
          'traineeId': traineeId,
          'present': isPresent,
          'comment': comment,
        },
      );

      final data = response.data;
      return AttendanceModel.fromJson(
        data['attendance'] as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
