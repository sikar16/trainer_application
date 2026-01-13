import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../models/cohort_model.dart';

class CohortRemoteDataSource {
  final ApiClient apiClient;

  CohortRemoteDataSource({required this.apiClient});

  /// Get cohorts by training
  Future<CohortListModel> getCohorts({
    required String trainingId,
    int page = 1,
    int pageSize = 100,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/cohort',
        queryParameters: {
          'training-id': trainingId,
          'page': page,
          'page-size': pageSize,
        },
      );

      final data = response.data;
      return CohortListModel.fromJson(data);
    } catch (e) {
      debugPrint('getCohorts error: $e');
      rethrow;
    }
  }
}
