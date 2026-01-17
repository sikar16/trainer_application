import '../../domain/entities/module_entity.dart';

class ModuleModel {
  final String id;
  final String name;
  final String description;
  final TrainingTagModel trainingTag;

  ModuleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.trainingTag,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      trainingTag: TrainingTagModel.fromJson(json['trainingTag'] ?? {}),
    );
  }

  ModuleEntity toEntity() {
    return ModuleEntity(
      id: id,
      name: name,
      description: description,
      trainingTag: trainingTag.toEntity(),
    );
  }
}

class TrainingTagModel {
  final String id;
  final String name;
  final String description;

  TrainingTagModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TrainingTagModel.fromJson(Map<String, dynamic> json) {
    return TrainingTagModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  TrainingTagEntity toEntity() {
    return TrainingTagEntity(id: id, name: name, description: description);
  }
}

class ModuleResponseModel {
  final String code;
  final String message;
  final List<ModuleModel> modules;

  ModuleResponseModel({
    required this.code,
    required this.message,
    required this.modules,
  });

  factory ModuleResponseModel.fromJson(Map<String, dynamic> json) {
    return ModuleResponseModel(
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      modules:
          (json['modules'] as List<dynamic>?)
              ?.map((module) => ModuleModel.fromJson(module))
              .toList() ??
          [],
    );
  }

  ModuleResponseEntity toEntity() {
    return ModuleResponseEntity(
      code: code,
      message: message,
      modules: modules.map((module) => module.toEntity()).toList(),
    );
  }
}
