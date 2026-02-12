class AssessmentEntity {
  final String id;
  final String name;
  final String type;
  final String description;
  final int duration;
  final int maxAttempts;
  final String approvalStatus;
  final int sectionCount;
  final bool timed;

  AssessmentEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.duration,
    required this.maxAttempts,
    required this.approvalStatus,
    required this.sectionCount,
    required this.timed,
  });

  factory AssessmentEntity.fromJson(Map<String, dynamic> json) {
    return AssessmentEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      duration: json['duration'] as int,
      maxAttempts: json['maxAttempts'] as int,
      approvalStatus: json['approvalStatus'] as String,
      sectionCount: json['sectionCount'] as int,
      timed: json['timed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'duration': duration,
      'maxAttempts': maxAttempts,
      'approvalStatus': approvalStatus,
      'sectionCount': sectionCount,
      'timed': timed,
    };
  }
}
