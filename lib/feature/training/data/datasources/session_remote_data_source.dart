import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../models/session_model.dart';

class SessionRemoteDataSource {
  final ApiClient apiClient;

  SessionRemoteDataSource({required this.apiClient});

  /// Get sessions by cohort
  Future<SessionListModel> getSessionsByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/session/cohort/$cohortId',
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      final data = response.data;
      return SessionListModel.fromJson(data);
    } catch (e) {
      debugPrint('getSessionsByCohort error: $e');
      rethrow;
    }
  }
}
