import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class EditProfileUseCase {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);

  Future<ProfileEntity> call(Map<String, dynamic> profileData) async {
    try {
      return await repository.editProfile(profileData);
    } catch (e) {
      rethrow; // let BLoC handle errors
    }
  }
}
