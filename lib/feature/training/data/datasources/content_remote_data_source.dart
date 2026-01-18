import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/content_model.dart';

abstract class ContentRemoteDataSource {
  Future<ContentResponseModel> getContents({
    required String trainingId,
    required int page,
    required int pageSize,
    String? searchQuery,
  });
}

class ContentRemoteDataSourceImpl implements ContentRemoteDataSource {
  final ApiClient _apiClient;

  ContentRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ContentResponseModel> getContents({
    required String trainingId,
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async {
    try {
      String url =
          '/api/content/training/$trainingId?page=$page&page-size=$pageSize';
      if (searchQuery != null && searchQuery.isNotEmpty) {
        url += '&search-query=$searchQuery';
      }

      final response = await _apiClient.get(url);

      if (response.statusCode == 200) {
        return ContentResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load content');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
