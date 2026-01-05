import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class EditProfileUseCase {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);

  Future<ProfileEntity> call(Map<String, dynamic> profileData) {
    return repository.editProfile(profileData);
  }
}
