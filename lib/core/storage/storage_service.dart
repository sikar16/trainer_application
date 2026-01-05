import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userDataKey = 'user_data';
  static const String _tokenKey = 'auth_token';

  // Save user data
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userDataKey, jsonEncode(userData));
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }

  // Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString(_userDataKey);
      if (userDataString != null) {
        return jsonDecode(userDataString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  // Save auth token
  static Future<void> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  // Get auth token
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }

  // Clear all data (logout)
  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userDataKey);
      await prefs.remove(_tokenKey);
    } catch (e) {
      throw Exception('Failed to clear data: $e');
    }
  }
}
