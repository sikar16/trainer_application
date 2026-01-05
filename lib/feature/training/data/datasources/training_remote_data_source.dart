import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/training_model.dart';
import '../../../../core/storage/storage_service.dart';

class TrainingRemoteDataSource {
  Future<TrainingListModel> getTrainings({
    int page = 1,
    int pageSize = 10,
  }) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.get(
      Uri.parse(
        'https://stg-training-api.icogacc.com/api/training?page=$page&page-size=$pageSize',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK') {
        return TrainingListModel.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch trainings');
      }
    } else {
      throw Exception('Failed to fetch trainings: ${response.statusCode}');
    }
  }

  Future<TrainingModel> getTrainingById(String id) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.get(
      Uri.parse('https://stg-training-api.icogacc.com/api/training/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK' && data['training'] != null) {
        return TrainingModel.fromJson(data['training'] as Map<String, dynamic>);
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch training');
      }
    } else {
      throw Exception('Failed to fetch training: ${response.statusCode}');
    }
  }
}
