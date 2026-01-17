import '../entities/audience_profile_entity.dart';

abstract class AudienceProfileRepository {
  Future<AudienceProfileResponseEntity> getAudienceProfile(String trainingId);
}
