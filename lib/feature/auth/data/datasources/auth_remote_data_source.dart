import '../models/user_model.dart';
import '../../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.post(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Login failed');
    }
  }
}
