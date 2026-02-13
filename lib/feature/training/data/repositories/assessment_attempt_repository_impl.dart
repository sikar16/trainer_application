import '../../domain/entities/assessment_attempt_entity.dart';
import '../../domain/repositories/assessment_attempt_repository.dart';
import '../datasources/assessment_attempt_remote_data_source.dart';

class AssessmentAttemptRepositoryImpl implements AssessmentAttemptRepository {
  final AssessmentAttemptRemoteDataSource remoteDataSource;

  AssessmentAttemptRepositoryImpl(this.remoteDataSource);

  @override
  Future<AssessmentAttemptEntity> getAssessmentAttempts(String assessmentId) {
    return remoteDataSource.getAssessmentAttempts(assessmentId);
  }
}
