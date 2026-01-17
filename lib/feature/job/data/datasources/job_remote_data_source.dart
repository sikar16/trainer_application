import '../../../../core/network/api_client.dart';
import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<JobModel> getJobs({
    int page = 1,
    int pageSize = 10,
    String? status,
    String? search,
  });
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final ApiClient _apiClient;

  JobRemoteDataSourceImpl(this._apiClient);

  @override
  Future<JobModel> getJobs({
    int page = 1,
    int pageSize = 10,
    String? status,
    String? search,
  }) async {
    try {
      String url = '/api/job?page=$page&pageSize=$pageSize';
      if (status != null && status.isNotEmpty) {
        url += '&status=$status';
      }
      if (search != null && search.isNotEmpty) {
        url += '&search=$search';
      }

      final response = await _apiClient.get(url);

      if (response.statusCode == 200) {
        return JobModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load jobs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }
}
