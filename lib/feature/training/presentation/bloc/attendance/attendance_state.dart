import '../../../domain/entities/attendance_entity.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final AttendanceListEntity attendanceList;

  AttendanceLoaded(this.attendanceList);
}

class AttendanceSaved extends AttendanceState {
  final AttendanceEntity attendance;

  AttendanceSaved(this.attendance);
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}
