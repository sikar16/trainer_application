import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<AttendanceListEntity> getAttendanceBySession(String sessionId) {
    return remoteDataSource.getAttendanceBySession(sessionId);
  }

  @override
  Future<AttendanceEntity> saveAttendance({
    required String sessionId,
    required String traineeId,
    required bool isPresent,
    String comment = '',
  }) {
    return remoteDataSource.saveAttendance(
      sessionId: sessionId,
      traineeId: traineeId,
      isPresent: isPresent,
      comment: comment,
    );
  }
}
