class JobEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime deadlineDate;
  final int numberOfSessions;
  final int applicantsRequired;
  final String status;

  JobEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadlineDate,
    required this.numberOfSessions,
    required this.applicantsRequired,
    required this.status,
  });

  factory JobEntity.fromJson(Map<String, dynamic> json) {
    return JobEntity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      deadlineDate: DateTime.parse(json['deadlineDate'] ?? ''),
      numberOfSessions: json['numberOfSessions'] ?? 0,
      applicantsRequired: json['applicantsRequired'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class JobResponseEntity {
  final List<JobEntity> jobs;
  final int totalPages;
  final int totalElements;
  final String code;
  final String message;

  JobResponseEntity({
    required this.jobs,
    required this.totalPages,
    required this.totalElements,
    required this.code,
    required this.message,
  });

  factory JobResponseEntity.fromJson(Map<String, dynamic> json) {
    return JobResponseEntity(
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
}
