import '../../domain/entities/assessment_entity.dart';
import '../../domain/repositories/assessment_repository.dart';
import '../datasources/assessment_remote_data_source.dart';
import '../models/assessment_model.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource remoteDataSource;

  AssessmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AssessmentEntity>> getAssessments(String trainingId) async {
    final assessmentModels = await remoteDataSource.getAssessments(trainingId);
    return assessmentModels.map((model) => _mapToEntity(model)).toList();
  }

  AssessmentEntity _mapToEntity(AssessmentModel model) {
    return AssessmentEntity(
      id: model.id,
      name: model.name,
      type: model.type,
      description: model.description,
      duration: model.duration,
      maxAttempts: model.maxAttempts,
      approvalStatus: model.approvalStatus,
      sectionCount: model.sectionCount,
      timed: model.timed,
    );
  }
}
