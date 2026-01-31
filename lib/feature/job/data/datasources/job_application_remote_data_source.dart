import '../../../../core/network/api_client.dart';
import 'package:dio/dio.dart';

class JobApplicationRemoteDataSource {
  final ApiClient apiClient;

  JobApplicationRemoteDataSource(this.apiClient);

  Future<void> submitJobApplication({
    required String jobId,
    required String reason,
    required String applicationType,
  }) async {
    String convertedApplicationType;
    if (applicationType.toLowerCase().contains('assistant')) {
      convertedApplicationType = 'ASSISTANT';
    } else if (applicationType.toLowerCase().contains('main')) {
      convertedApplicationType = 'MAIN';
    } else {
      convertedApplicationType = applicationType.toUpperCase();
    }

    final requestData = {
      'jobId': jobId,
      'reason': reason,
      'applicationType': convertedApplicationType,
    };

    final response = await apiClient.post(
      '/api/application',
      data: requestData,
      options: Options(validateStatus: (status) => true),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      String errorMessage = 'Application failed';

      if (response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        errorMessage =
            responseData['message'] ?? responseData['error'] ?? errorMessage;
      } else if (response.data != null) {
        errorMessage = response.data.toString();
      }

      throw Exception(errorMessage);
    }
  }
}
