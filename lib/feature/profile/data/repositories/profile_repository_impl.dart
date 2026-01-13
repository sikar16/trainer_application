import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() async {
    final ProfileModel profile = await remoteDataSource.getProfile();
    return profile;
  }

  @override
  Future<ProfileEntity> editProfile(Map<String, dynamic> profileData) async {
    final ProfileModel profile = await remoteDataSource.editProfile(
      profileData,
    );
    return profile;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
