import '../../domain/entities/audience_profile_entity.dart';
import '../../domain/repositories/audience_profile_repository.dart';
import '../datasources/audience_profile_remote_data_source.dart';

class AudienceProfileRepositoryImpl implements AudienceProfileRepository {
  final AudienceProfileRemoteDataSource _remoteDataSource;

  AudienceProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<AudienceProfileResponseEntity> getAudienceProfile(
    String trainingId,
  ) async {
    final audienceProfileModel = await _remoteDataSource.getAudienceProfile(
      trainingId,
    );
    return AudienceProfileResponseEntity(
      audienceProfile: audienceProfileModel.audienceProfile,
      code: audienceProfileModel.code,
      message: audienceProfileModel.message,
    );
  }
}
