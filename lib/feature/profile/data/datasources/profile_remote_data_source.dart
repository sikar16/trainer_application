import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_model.dart';
import '../../../../core/storage/storage_service.dart';

class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile() async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.get(
      Uri.parse('https://stg-training-api.icogacc.com/api/user/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK' && data['user'] != null) {
        return ProfileModel.fromJson(data['user'] as Map<String, dynamic>);
      } else {
        throw Exception(data['message'] ?? 'Failed to fetch profile');
      }
    } else {
      throw Exception('Failed to fetch profile: ${response.statusCode}');
    }
  }

  Future<ProfileModel> editProfile(Map<String, dynamic> profileData) async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final response = await http.put(
      Uri.parse('https://stg-training-api.icogacc.com/api/user/edit-profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'] == 'OK' && data['user'] != null) {
        return ProfileModel.fromJson(data['user'] as Map<String, dynamic>);
      } else {
        throw Exception(data['message'] ?? 'Failed to update profile');
      }
    } else {
      String errorMessage = 'Failed to update profile: ${response.statusCode}';
      try {
        final errorData = jsonDecode(response.body);
        if (errorData['message'] != null) {
          errorMessage = errorData['message'] as String;
        } else if (errorData['error'] != null) {
          errorMessage = errorData['error'] as String;
        }
      } catch (e) {
        errorMessage =
            'Failed to update profile: ${response.statusCode}\n${response.body}';
      }
      throw Exception(errorMessage);
    }
  }
}
