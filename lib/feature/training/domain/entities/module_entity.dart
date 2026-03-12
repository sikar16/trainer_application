class ModuleEntity {
  final String id;
  final String name;
  final String description;
  final TrainingTagEntity trainingTag;
  final ModuleEntity? parentModule;
  final List<ModuleEntity> childModules;

  ModuleEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.trainingTag,
    this.parentModule,
    this.childModules = const [],
  });
}

class TrainingTagEntity {
  final String id;
  final String name;
  final String description;

  TrainingTagEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class ModuleResponseEntity {
  final String code;
  final String message;
  final List<ModuleEntity> modules;

  ModuleResponseEntity({
    required this.code,
    required this.message,
    required this.modules,
  });
}
