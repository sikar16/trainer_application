import 'dart:io';
import '../../domain/entities/trainee_entity.dart';
import '../../domain/repositories/trainee_repository.dart';
import '../datasources/trainee_remote_data_source.dart';

class TraineeRepositoryImpl implements TraineeRepository {
  final TraineeRemoteDataSource remoteDataSource;

  TraineeRepositoryImpl(this.remoteDataSource);

  @override
  Future<TraineeListEntity> getTraineesByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  }) {
    return remoteDataSource.getTraineesByCohort(
      cohortId: cohortId,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<Map<String, dynamic>> updateTraineeId({
    required String pendingTraineeId,
    required String idType,
    required String idFrontFilePath,
    String? idBackFilePath,
  }) {
    return remoteDataSource.updateTraineeId(
      pendingTraineeId: pendingTraineeId,
      idType: idType,
      idFrontFile: File(idFrontFilePath),
      idBackFile: idBackFilePath != null ? File(idBackFilePath) : null,
    );
  }

  @override
  Future<Map<String, dynamic>> uploadConsentForm({
    required String pendingTraineeId,
    required String consentFormFilePath,
  }) {
    return remoteDataSource.uploadConsentForm(
      pendingTraineeId: pendingTraineeId,
      consentFormFile: File(consentFormFilePath),
    );
  }
}
