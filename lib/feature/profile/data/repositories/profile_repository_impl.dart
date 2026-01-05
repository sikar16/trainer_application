import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() {
    return remoteDataSource.getProfile();
  }

  @override
  Future<ProfileEntity> editProfile(Map<String, dynamic> profileData) {
    return remoteDataSource.editProfile(profileData);
  }
}
