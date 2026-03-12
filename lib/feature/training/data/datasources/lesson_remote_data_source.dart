import '../../../../core/network/api_client.dart';
import '../models/lesson_model.dart';

class LessonRemoteDataSource {
  final ApiClient apiClient;

  LessonRemoteDataSource({required this.apiClient});

  Future<List<LessonModel>> getLessonsByModule(String moduleId) async {
    try {
      final response = await apiClient.get(
        '/api/lesson/module/$moduleId',
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final lessonsList = data['lessons'] as List<dynamic>;
        
        return lessonsList
            .map((lessonJson) => LessonModel.fromJson(
              lessonJson as Map<String, dynamic>,
            ))
            .toList();
      } else {
        throw Exception('Failed to load lessons: Status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching lessons: $e');
    }
  }
}
