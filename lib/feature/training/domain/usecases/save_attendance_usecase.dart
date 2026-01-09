import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class SaveAttendanceUseCase {
  final AttendanceRepository repository;

  SaveAttendanceUseCase(this.repository);

  Future<AttendanceEntity> call({
    required String sessionId,
    required String traineeId,
    required bool isPresent,
    String comment = '',
  }) {
    return repository.saveAttendance(
      sessionId: sessionId,
      traineeId: traineeId,
      isPresent: isPresent,
      comment: comment,
    );
  }
}
