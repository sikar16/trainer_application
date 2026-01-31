import '../repositories/trainee_repository.dart';

class UploadConsentFormUseCase {
  final TraineeRepository repository;

  UploadConsentFormUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required String pendingTraineeId,
    required String consentFormFilePath,
  }) {
    return repository.uploadConsentForm(
      pendingTraineeId: pendingTraineeId,
      consentFormFilePath: consentFormFilePath,
    );
  }
}
