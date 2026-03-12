import 'package:dio/dio.dart';
import '../models/lesson_model.dart';

class LessonService {
  final Dio _dio;

  LessonService(this._dio);

  Future<LessonResponseModel> getLessonsByModule(String moduleId) async {
    try {
      final response = await _dio.get(
        'https://stg-training-api.icogacc.com/api/lesson/module/$moduleId',
      );

      if (response.statusCode == 200) {
        return LessonResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load lessons');
      }
    } catch (e) {
      throw Exception('Error fetching lessons: $e');
    }
  }
}
