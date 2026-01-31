import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../models/trainee_model.dart';

class TraineeRemoteDataSource {
  final ApiClient apiClient;

  TraineeRemoteDataSource({required this.apiClient});

  Future<TraineeListModel> getTraineesByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/cohort/$cohortId/trainees',
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      final data = response.data;
      return TraineeListModel.fromJson(data);
    } catch (e) {
      debugPrint('getTraineesByCohort error: $e');
      rethrow;
    }
  }
}
