import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<AttendanceListEntity> getAttendanceBySession(String sessionId);
  Future<AttendanceEntity> saveAttendance({
    required String sessionId,
    required String traineeId,
    required bool isPresent,
    String comment = '',
  });
}
