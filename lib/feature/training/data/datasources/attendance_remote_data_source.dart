import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attendance_model.dart';
import '../../../../core/storage/storage_service.dart';

class AttendanceRemoteDataSource {
  Future<AttendanceListModel> getAttendanceBySession(String sessionId) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.get(
      Uri.parse(
        'https://stg-training-api.icogacc.com/api/attendance/session/$sessionId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK') {
        return AttendanceListModel.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch attendance');
      }
    } else {
      throw Exception('Failed to fetch attendance: ${response.statusCode}');
    }
  }

  Future<AttendanceModel> saveAttendance({
    required String sessionId,
    required String traineeId,
    required bool isPresent,
    String comment = '',
  }) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.post(
      Uri.parse('https://stg-training-api.icogacc.com/api/attendance'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'sessionId': sessionId,
        'traineeId': traineeId,
        'isPresent': isPresent,
        'comment': comment,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK' && data['attendance'] != null) {
        return AttendanceModel.fromJson(
          data['attendance'] as Map<String, dynamic>,
        );
      } else {
        throw Exception(data['message'] ?? 'Failed to save attendance');
      }
    } else {
      try {
        final errorData = jsonDecode(response.body);
        throw Exception(
          errorData['message'] ??
              'Failed to save attendance: ${response.statusCode}',
        );
      } catch (e) {
        throw Exception(
          'Failed to save attendance: ${response.statusCode} - ${response.body}',
        );
      }
    }
  }
}
