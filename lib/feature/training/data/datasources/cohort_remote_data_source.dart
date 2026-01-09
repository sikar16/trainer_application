import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cohort_model.dart';
import '../../../../core/storage/storage_service.dart';

class CohortRemoteDataSource {
  Future<CohortListModel> getCohorts({
    required String trainingId,
    int page = 1,
    int pageSize = 100,
  }) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.get(
      Uri.parse(
        'https://stg-training-api.icogacc.com/api/cohort?training-id=$trainingId&page=$page&page-size=$pageSize',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK') {
        return CohortListModel.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch cohorts');
      }
    } else {
      throw Exception('Failed to fetch cohorts: ${response.statusCode}');
    }
  }
}
