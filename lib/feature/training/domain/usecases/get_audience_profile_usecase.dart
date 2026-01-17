import '../entities/audience_profile_entity.dart';
import '../repositories/audience_profile_repository.dart';

class GetAudienceProfileUseCase {
  final AudienceProfileRepository _repository;

  GetAudienceProfileUseCase(this._repository);

  Future<AudienceProfileResponseEntity> call(String trainingId) async {
    return await _repository.getAudienceProfile(trainingId);
  }
}
