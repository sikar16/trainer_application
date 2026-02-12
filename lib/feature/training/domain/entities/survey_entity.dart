class SurveyEntity {
  final String id;
  final String name;
  final String type;
  final String description;
  final int sectionCount;

  SurveyEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.sectionCount,
  });

  factory SurveyEntity.fromJson(Map<String, dynamic> json) {
    return SurveyEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      sectionCount: json['sectionCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'sectionCount': sectionCount,
    };
  }
}
