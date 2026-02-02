import 'dart:convert';
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

      Map<String, dynamic> parsedData;
      if (data is String) {
        if (data.isEmpty) {
          throw Exception('Empty response from server');
        }
        try {
          parsedData = jsonDecode(data) as Map<String, dynamic>;
        } catch (e) {
          throw Exception('Invalid JSON response: $e');
        }
      } else {
        parsedData = data as Map<String, dynamic>;
      }

      return TrainingListModel.fromJson(parsedData);
    } catch (e) {
      rethrow;
    }
  }

  Future<TrainingModel> getTrainingById(String id) async {
    try {
      final response = await apiClient.get('/api/training/$id');

      final data = response.data;
      return TrainingModel.fromJson(data['training'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
