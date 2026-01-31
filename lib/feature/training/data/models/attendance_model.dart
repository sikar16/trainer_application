import '../../domain/entities/attendance_entity.dart';
import 'trainee_model.dart';

class AttendanceModel extends AttendanceEntity {
  AttendanceModel({
    required super.id,
    required super.trainee,
    required super.isPresent,
    required super.comment,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id']?.toString() ?? '',
      trainee: TraineeModel.fromJson(
        json['trainee'] as Map<String, dynamic>? ?? {},
      ),
      isPresent: json['isPresent'] as bool? ?? false,
      comment: json['comment']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'traineeId': trainee.id,
      'isPresent': isPresent,
      'comment': comment,
    };
  }
}

class AttendanceListModel extends AttendanceListEntity {
  AttendanceListModel({required super.attendance, required super.message});

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) {
    return AttendanceListModel(
      attendance:
          (json['attendance'] as List<dynamic>?)
              ?.map(
                (attendance) => AttendanceModel.fromJson(
                  attendance as Map<String, dynamic>? ?? {},
                ),
              )
              .toList() ??
          [],
      message: json['message']?.toString() ?? '',
    );
  }
}
