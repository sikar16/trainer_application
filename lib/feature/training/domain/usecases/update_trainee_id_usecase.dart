import '../repositories/trainee_repository.dart';

class UpdateTraineeIdUseCase {
  final TraineeRepository repository;

  UpdateTraineeIdUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required String pendingTraineeId,
    required String idType,
    required String idFrontFilePath,
    String? idBackFilePath,
  }) {
    return repository.updateTraineeId(
      pendingTraineeId: pendingTraineeId,
      idType: idType,
      idFrontFilePath: idFrontFilePath,
      idBackFilePath: idBackFilePath,
    );
  }
}
