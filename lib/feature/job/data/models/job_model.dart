import '../../domain/entities/job_entity.dart';

class JobModel extends JobResponseEntity {
  JobModel({
    required super.jobs,
    required super.totalPages,
    required super.totalElements,
    required super.code,
    required super.message,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      jobs:
          (json['jobs'] as List<dynamic>?)
              ?.map((job) => JobEntity.fromJson(job))
              .toList() ??
          [],
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobs': jobs.map((job) => job.toJson()).toList(),
      'totalPages': totalPages,
      'totalElements': totalElements,
      'code': code,
      'message': message,
    };
  }
}

extension JobEntityExtension on JobEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'deadlineDate': deadlineDate.toIso8601String(),
      'numberOfSessions': numberOfSessions,
      'applicantsRequired': applicantsRequired,
      'status': status,
    };
  }
}
