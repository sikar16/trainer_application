import 'trainee_entity.dart';

class AttendanceEntity {
  final String id;
  final TraineeEntity trainee;
  final bool isPresent;
  final String comment;

  AttendanceEntity({
    required this.id,
    required this.trainee,
    required this.isPresent,
    required this.comment,
  });
}

class AttendanceListEntity {
  final List<AttendanceEntity> attendance;
  final String message;

  AttendanceListEntity({
    required this.attendance,
    required this.message,
  });
}
