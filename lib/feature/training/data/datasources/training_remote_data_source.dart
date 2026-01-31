import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../models/training_model.dart';

class TrainingRemoteDataSource {
  final ApiClient apiClient;

  TrainingRemoteDataSource({required this.apiClient});

  Future<TrainingListModel> getTrainings({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/training',
        queryParameters: {'page': page, 'page-size': pageSize},
      );

      final data = response.data;
      return TrainingListModel.fromJson(data);
    } catch (e) {
      debugPrint('getTrainings error: $e');
      rethrow;
    }
  }

  Future<TrainingModel> getTrainingById(String id) async {
    try {
      final response = await apiClient.get('/api/training/$id');

      final data = response.data;
      return TrainingModel.fromJson(data['training'] as Map<String, dynamic>);
    } catch (e) {
      debugPrint('getTrainingById error: $e');
      rethrow;
    }
  }
}
