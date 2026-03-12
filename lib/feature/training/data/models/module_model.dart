import '../../domain/entities/module_entity.dart';

class ModuleModel {
  final String id;
  final String name;
  final String description;
  final TrainingTagModel trainingTag;
  final ModuleModel? parentModule;
  final List<ModuleModel> childModules;

  ModuleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.trainingTag,
    this.parentModule,
    this.childModules = const [],
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      trainingTag: TrainingTagModel.fromJson(json['trainingTag'] ?? {}),
      parentModule: json['parentModule'] != null
          ? ModuleModel.fromJson(json['parentModule'])
          : null,
      childModules:
          (json['childModules'] as List<dynamic>?)
              ?.map((child) => ModuleModel.fromJson(child))
              .toList() ??
          [],
    );
  }

  ModuleEntity toEntity() {
    return ModuleEntity(
      id: id,
      name: name,
      description: description,
      trainingTag: trainingTag.toEntity(),
      parentModule: parentModule?.toEntity(),
      childModules: childModules.map((child) => child.toEntity()).toList(),
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
    // Handle both single module and array responses
    if (json.containsKey('module')) {
      // Single module response
      final moduleJson = json['module'] as Map<String, dynamic>;
      return ModuleResponseModel(
        code: json['code'] ?? '',
        message: json['message'] ?? '',
        modules: [ModuleModel.fromJson(moduleJson)],
      );
    } else {
      // Array response
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
  }

  ModuleResponseEntity toEntity() {
    return ModuleResponseEntity(
      code: code,
      message: message,
      modules: modules.map((module) => module.toEntity()).toList(),
    );
  }
}
