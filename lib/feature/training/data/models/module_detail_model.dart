import 'package:gheero/feature/training/domain/entities/module_detail_entity.dart';

class ModuleDetailModel {
  final String moduleId;
  final String name;
  final String keyConcepts;
  final List<String> primaryMaterials;
  final List<String> secondaryMaterials;
  final List<String> digitalTools;
  final List<InstructionMethodModel> instructionMethods;
  final String differentationStrategies;
  final TechnologyIntegrationModel technologyIntegration;
  final String technologyIntegrationDescription;
  final String inclusionStrategy;
  final String teachingStrategy;
  final double duration;
  final String durationType;

  const ModuleDetailModel({
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

  factory ModuleDetailModel.fromJson(Map<String, dynamic> json) {
    return ModuleDetailModel(
      moduleId: json['moduleId'] ?? '',
      name: json['name'] ?? '',
      keyConcepts: json['keyConcepts'] ?? '',
      primaryMaterials: List<String>.from(json['primaryMaterials'] ?? []),
      secondaryMaterials: List<String>.from(json['secondaryMaterials'] ?? []),
      digitalTools: List<String>.from(json['digitalTools'] ?? []),
      instructionMethods:
          (json['instructionMethods'] as List<dynamic>?)
              ?.map((e) => InstructionMethodModel.fromJson(e))
              .toList() ??
          [],
      differentationStrategies: json['differentationStrategies'] ?? '',
      technologyIntegration: TechnologyIntegrationModel.fromJson(
        json['technologyIntegration'] ?? {},
      ),
      technologyIntegrationDescription:
          json['technologyIntegrationDescription'] ?? '',
      inclusionStrategy: json['inclusionStrategy'] ?? '',
      teachingStrategy: json['teachingStrategy'] ?? '',
      duration: (json['duration'] ?? 0).toDouble(),
      durationType: json['durationType'] ?? '',
    );
  }

  ModuleDetailEntity toEntity() {
    return ModuleDetailEntity(
      moduleId: moduleId,
      name: name,
      keyConcepts: keyConcepts,
      primaryMaterials: primaryMaterials,
      secondaryMaterials: secondaryMaterials,
      digitalTools: digitalTools,
      instructionMethods: instructionMethods.map((e) => e.toEntity()).toList(),
      differentationStrategies: differentationStrategies,
      technologyIntegration: technologyIntegration.toEntity(),
      technologyIntegrationDescription: technologyIntegrationDescription,
      inclusionStrategy: inclusionStrategy,
      teachingStrategy: teachingStrategy,
      duration: duration,
      durationType: durationType,
    );
  }
}

class InstructionMethodModel {
  final String id;
  final String name;
  final String description;

  const InstructionMethodModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory InstructionMethodModel.fromJson(Map<String, dynamic> json) {
    return InstructionMethodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  InstructionMethodEntity toEntity() {
    return InstructionMethodEntity(
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

  const TechnologyIntegrationModel({
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

class AssessmentMethodModel {
  final String id;
  final String name;
  final String description;
  final String assessmentSubType;

  const AssessmentMethodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.assessmentSubType,
  });

  factory AssessmentMethodModel.fromJson(Map<String, dynamic> json) {
    return AssessmentMethodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      assessmentSubType: json['assessmentSubType'] ?? '',
    );
  }

  AssessmentMethodEntity toEntity() {
    return AssessmentMethodEntity(
      id: id,
      name: name,
      description: description,
      assessmentSubType: assessmentSubType,
    );
  }
}

class ModuleAssessmentMethodsModel {
  final String moduleId;
  final List<AssessmentMethodModel> assessmentMethods;

  const ModuleAssessmentMethodsModel({
    required this.moduleId,
    required this.assessmentMethods,
  });

  factory ModuleAssessmentMethodsModel.fromJson(Map<String, dynamic> json) {
    final moduleAssessmentMethods = json['moduleAssessmentMethods'] ?? {};
    return ModuleAssessmentMethodsModel(
      moduleId: moduleAssessmentMethods['moduleId'] ?? '',
      assessmentMethods:
          (moduleAssessmentMethods['assessmentMethods'] as List<dynamic>?)
              ?.map((e) => AssessmentMethodModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  ModuleAssessmentMethodsEntity toEntity() {
    return ModuleAssessmentMethodsEntity(
      moduleId: moduleId,
      assessmentMethods: assessmentMethods.map((e) => e.toEntity()).toList(),
    );
  }
}

class ModuleProfileModel {
  final ModuleDetailModel moduleProfile;

  const ModuleProfileModel({required this.moduleProfile});

  factory ModuleProfileModel.fromJson(Map<String, dynamic> json) {
    return ModuleProfileModel(
      moduleProfile: ModuleDetailModel.fromJson(json['moduleProfile'] ?? {}),
    );
  }

  ModuleProfileEntity toEntity() {
    return ModuleProfileEntity(moduleProfile: moduleProfile.toEntity());
  }
}
