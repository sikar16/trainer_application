import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/session_model.dart';
import '../../../../core/storage/storage_service.dart';

class SessionRemoteDataSource {
  Future<SessionListModel> getSessionsByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 20,
  }) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.get(
      Uri.parse(
        'https://stg-training-api.icogacc.com/api/session/cohort/$cohortId?page=$page&pageSize=$pageSize',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK') {
        return SessionListModel.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch sessions');
      }
    } else {
      throw Exception('Failed to fetch sessions: ${response.statusCode}');
    }
  }
}
