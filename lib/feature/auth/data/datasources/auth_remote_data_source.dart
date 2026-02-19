import '../models/user_model.dart';
import '../../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.postCurriculum(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      String errorMessage = 'Login failed';

      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        errorMessage = data['message'] ?? 'Login failed';
      }
      throw Exception(errorMessage);
    }
  }
}
