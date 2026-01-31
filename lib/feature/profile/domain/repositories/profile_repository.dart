import '../entities/profile_entity.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../../data/models/edit_profile_request_model.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<EditProfileResponseModel> editProfile(
    EditProfileRequestModel profileData,
  );
  Future<void> logout();
}
