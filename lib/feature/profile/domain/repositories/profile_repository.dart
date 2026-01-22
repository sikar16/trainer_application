import '../entities/profile_entity.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../../data/models/edit_profile_request_model.dart';

abstract class ProfileRepository {
  /// Fetches the user profile from the data source
  Future<ProfileEntity> getProfile();

  /// Updates the user profile with the given data
  Future<EditProfileResponseModel> editProfile(
    EditProfileRequestModel profileData,
  );

  /// Logs out the user
  Future<void> logout();
}
