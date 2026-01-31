import '../entities/trainee_entity.dart';

abstract class TraineeRepository {
  Future<TraineeListEntity> getTraineesByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  });

  Future<Map<String, dynamic>> updateTraineeId({
    required String pendingTraineeId,
    required String idType,
    required String idFrontFilePath,
    String? idBackFilePath,
  });

  Future<Map<String, dynamic>> uploadConsentForm({
    required String pendingTraineeId,
    required String consentFormFilePath,
  });
}
