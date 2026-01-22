import '../repositories/profile_repository.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../../data/models/edit_profile_request_model.dart';

class EditProfileUseCase {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);

  Future<EditProfileResponseModel> call(
    EditProfileRequestModel profileData,
  ) async {
    try {
      return await repository.editProfile(profileData);
    } catch (e) {
      rethrow;
    }
  }
}
