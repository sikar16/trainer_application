class LessonEntity {
  final String id;
  final String name;
  final String objective;
  final String description;
  final double duration;
  final String durationType;
  final List<InstructionalMethodEntity> instructionalMethods;
  final List<TechnologyIntegrationEntity> technologyIntegrations;

  LessonEntity({
    required this.id,
    required this.name,
    required this.objective,
    required this.description,
    required this.duration,
    required this.durationType,
    required this.instructionalMethods,
    required this.technologyIntegrations,
  });
}

class InstructionalMethodEntity {
  final String id;
  final String name;
  final String description;

  InstructionalMethodEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class TechnologyIntegrationEntity {
  final String id;
  final String name;
  final String description;

  TechnologyIntegrationEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class LessonResponseEntity {
  final String code;
  final String message;
  final List<LessonEntity> lessons;

  LessonResponseEntity({
    required this.code,
    required this.message,
    required this.lessons,
  });
}
