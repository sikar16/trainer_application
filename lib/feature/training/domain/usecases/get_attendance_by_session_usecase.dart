import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceBySessionUseCase {
  final AttendanceRepository repository;

  GetAttendanceBySessionUseCase(this.repository);

  Future<AttendanceListEntity> call(String sessionId) {
    return repository.getAttendanceBySession(sessionId);
  }
}
