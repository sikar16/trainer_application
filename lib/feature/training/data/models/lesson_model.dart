import '../../domain/entities/lesson_entity.dart';

class LessonModel {
  final String id;
  final String name;
  final String objective;
  final String description;
  final double duration;
  final String durationType;
  final List<InstructionalMethodModel> instructionalMethods;
  final List<TechnologyIntegrationModel> technologyIntegrations;

  LessonModel({
    required this.id,
    required this.name,
    required this.objective,
    required this.description,
    required this.duration,
    required this.durationType,
    required this.instructionalMethods,
    required this.technologyIntegrations,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      objective: json['objective'] ?? '',
      description: json['description'] ?? '',
      duration: (json['duration'] ?? 0).toDouble(),
      durationType: json['durationType'] ?? '',
      instructionalMethods: (json['instructionalMethods'] as List<dynamic>?)
          ?.map((e) => InstructionalMethodModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      technologyIntegrations: (json['technologyIntegrations'] as List<dynamic>?)
          ?.map((e) => TechnologyIntegrationModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  LessonEntity toEntity() {
    return LessonEntity(
      id: id,
      name: name,
      objective: objective,
      description: description,
      duration: duration,
      durationType: durationType,
      instructionalMethods: instructionalMethods.map((e) => e.toEntity()).toList(),
      technologyIntegrations: technologyIntegrations.map((e) => e.toEntity()).toList(),
    );
  }
}

class InstructionalMethodModel {
  final String id;
  final String name;
  final String description;

  InstructionalMethodModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory InstructionalMethodModel.fromJson(Map<String, dynamic> json) {
    return InstructionalMethodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  InstructionalMethodEntity toEntity() {
    return InstructionalMethodEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}

class TechnologyIntegrationModel {
  final String id;
  final String name;
  final String description;

  TechnologyIntegrationModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TechnologyIntegrationModel.fromJson(Map<String, dynamic> json) {
    return TechnologyIntegrationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  TechnologyIntegrationEntity toEntity() {
    return TechnologyIntegrationEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}

class LessonResponseModel {
  final String code;
  final String message;
  final List<LessonModel> lessons;

  LessonResponseModel({
    required this.code,
    required this.message,
    required this.lessons,
  });

  factory LessonResponseModel.fromJson(Map<String, dynamic> json) {
    return LessonResponseModel(
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  LessonResponseEntity toEntity() {
    return LessonResponseEntity(
      code: code,
      message: message,
      lessons: lessons.map((e) => e.toEntity()).toList(),
    );
  }
}
