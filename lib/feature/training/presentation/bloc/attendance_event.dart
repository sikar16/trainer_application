abstract class AttendanceEvent {}

class GetAttendanceBySessionEvent extends AttendanceEvent {
  final String sessionId;

  GetAttendanceBySessionEvent(this.sessionId);
}

class SaveAttendanceEvent extends AttendanceEvent {
  final String sessionId;
  final String traineeId;
  final bool isPresent;
  final String comment;

  SaveAttendanceEvent({
    required this.sessionId,
    required this.traineeId,
    required this.isPresent,
    this.comment = '',
  });
}
