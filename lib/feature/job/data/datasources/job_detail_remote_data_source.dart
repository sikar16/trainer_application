import '../../../../core/network/api_client.dart';
import '../models/job_detail_model.dart';

abstract class JobDetailRemoteDataSource {
  Future<JobDetailResponseModel> getJobDetail(String jobId);
}

class JobDetailRemoteDataSourceImpl implements JobDetailRemoteDataSource {
  final ApiClient _apiClient;

  JobDetailRemoteDataSourceImpl(this._apiClient);

  @override
  Future<JobDetailResponseModel> getJobDetail(String jobId) async {
    final response = await _apiClient.get('/api/job/$jobId');

    if (response.statusCode == 200) {
      return JobDetailResponseModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load job detail');
    }
  }
}
