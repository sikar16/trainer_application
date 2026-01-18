class ModuleDetailEntity {
  final String moduleId;
  final String name;
  final String keyConcepts;
  final List<String> primaryMaterials;
  final List<String> secondaryMaterials;
  final List<String> digitalTools;
  final List<InstructionMethodEntity> instructionMethods;
  final String differentationStrategies;
  final TechnologyIntegrationEntity technologyIntegration;
  final String technologyIntegrationDescription;
  final String inclusionStrategy;
  final String teachingStrategy;
  final double duration;
  final String durationType;

  const ModuleDetailEntity({
    required this.moduleId,
    required this.name,
    required this.keyConcepts,
    required this.primaryMaterials,
    required this.secondaryMaterials,
    required this.digitalTools,
    required this.instructionMethods,
    required this.differentationStrategies,
    required this.technologyIntegration,
    required this.technologyIntegrationDescription,
    required this.inclusionStrategy,
    required this.teachingStrategy,
    required this.duration,
    required this.durationType,
  });
}

class InstructionMethodEntity {
  final String id;
  final String name;
  final String description;

  const InstructionMethodEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class TechnologyIntegrationEntity {
  final String id;
  final String name;
  final String description;

  const TechnologyIntegrationEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class AssessmentMethodEntity {
  final String id;
  final String name;
  final String description;
  final String assessmentSubType;

  const AssessmentMethodEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.assessmentSubType,
  });
}

class ModuleProfileEntity {
  final ModuleDetailEntity moduleProfile;

  const ModuleProfileEntity({required this.moduleProfile});
}

class ModuleAssessmentMethodsEntity {
  final String moduleId;
  final List<AssessmentMethodEntity> assessmentMethods;

  const ModuleAssessmentMethodsEntity({
    required this.moduleId,
    required this.assessmentMethods,
  });
}
