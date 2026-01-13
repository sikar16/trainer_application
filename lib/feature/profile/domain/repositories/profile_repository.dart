import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  /// Fetches the user profile from the data source
  Future<ProfileEntity> getProfile();

  /// Updates the user profile with the given data
  Future<ProfileEntity> editProfile(Map<String, dynamic> profileData);

  /// Logs out the user
  Future<void> logout();
}
