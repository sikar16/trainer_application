import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_model.dart';
import '../models/edit_profile_response_model.dart';
import '../models/edit_profile_request_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() async {
    final ProfileModel profile = await remoteDataSource.getProfile();
    return profile;
  }

  @override
  Future<EditProfileResponseModel> editProfile(
    EditProfileRequestModel profileData,
  ) async {
    final EditProfileResponseModel response = await remoteDataSource
        .editProfile(profileData);
    return response;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
