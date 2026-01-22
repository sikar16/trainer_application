import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../models/profile_model.dart';
import '../models/edit_profile_response_model.dart';
import '../models/edit_profile_request_model.dart';

class ProfileRemoteDataSource {
  final ApiClient _apiClient;

  // Inject ApiClient via constructor (DI)
  ProfileRemoteDataSource(this._apiClient);

  /// Fetch the current user profile
  Future<ProfileModel> getProfile() async {
    try {
      final response = await _apiClient.get('/api/user/me');
      final profile = ProfileModel.fromJson(
        response.data['user'] as Map<String, dynamic>,
      );
      return profile;
    } catch (e) {
      debugPrint('getProfile error: $e');
      rethrow;
    }
  }

  /// Edit the current user profile
  Future<EditProfileResponseModel> editProfile(
    EditProfileRequestModel profileData,
  ) async {
    try {
      final response = await _apiClient.patch(
        '/api/user/edit-profile',
        data: profileData.toJson(),
      );

      return EditProfileResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      debugPrint('editProfile error: $e');
      rethrow;
    }
  }

  // logout
  Future<void> logout() async {
    try {
      await _apiClient.postCurriculum('/api/auth/logout', data: {});
    } on DioException catch (_) {
      rethrow;
    }
  }
}
