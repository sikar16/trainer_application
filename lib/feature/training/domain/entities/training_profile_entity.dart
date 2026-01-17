class TrainingProfileEntity {
  final String trainingId;
  final List<String> keywords;
  final String scope;
  final double attendanceRequirementPercentage;
  final double assessmentResultPercentage;
  final List<AlignmentWithStandardEntity> alignmentsWithStandard;
  final List<DeliveryToolEntity> deliveryTools;
  final List<TechnologicalRequirementEntity> learnerTechnologicalRequirements;
  final List<TechnologicalRequirementEntity>
  instructorTechnologicalRequirements;
  final List<dynamic> priorKnowledgeList;
  final List<LearnerStylePreferenceEntity> learnerStylePreferences;
  final String professionalBackground;

  TrainingProfileEntity({
    required this.trainingId,
    required this.keywords,
    required this.scope,
    required this.attendanceRequirementPercentage,
    required this.assessmentResultPercentage,
    required this.alignmentsWithStandard,
    required this.deliveryTools,
    required this.learnerTechnologicalRequirements,
    required this.instructorTechnologicalRequirements,
    required this.priorKnowledgeList,
    required this.learnerStylePreferences,
    required this.professionalBackground,
  });

  factory TrainingProfileEntity.fromJson(Map<String, dynamic> json) {
    return TrainingProfileEntity(
      trainingId: json['trainingId'] ?? '',
      keywords: List<String>.from(json['keywords'] ?? []),
      scope: json['scope'] ?? '',
      attendanceRequirementPercentage:
          (json['attendanceRequirementPercentage'] ?? 0).toDouble(),
      assessmentResultPercentage: (json['assessmentResultPercentage'] ?? 0)
          .toDouble(),
      alignmentsWithStandard:
          (json['alignmentsWithStandard'] as List?)
              ?.map((item) => AlignmentWithStandardEntity.fromJson(item))
              .toList() ??
          [],
      deliveryTools:
          (json['deliveryTools'] as List?)
              ?.map((item) => DeliveryToolEntity.fromJson(item))
              .toList() ??
          [],
      learnerTechnologicalRequirements:
          (json['learnerTechnologicalRequirements'] as List?)
              ?.map((item) => TechnologicalRequirementEntity.fromJson(item))
              .toList() ??
          [],
      instructorTechnologicalRequirements:
          (json['instructorTechnologicalRequirements'] as List?)
              ?.map((item) => TechnologicalRequirementEntity.fromJson(item))
              .toList() ??
          [],
      priorKnowledgeList: json['priorKnowledgeList'] ?? [],
      learnerStylePreferences:
          (json['learnerStylePreferences'] as List?)
              ?.map((item) => LearnerStylePreferenceEntity.fromJson(item))
              .toList() ??
          [],
      professionalBackground: json['professionalBackground'] ?? '',
    );
  }
}

class AlignmentWithStandardEntity {
  final String id;
  final String name;
  final String description;

  AlignmentWithStandardEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory AlignmentWithStandardEntity.fromJson(Map<String, dynamic> json) {
    return AlignmentWithStandardEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class DeliveryToolEntity {
  final String id;
  final String name;
  final String description;

  DeliveryToolEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DeliveryToolEntity.fromJson(Map<String, dynamic> json) {
    return DeliveryToolEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class TechnologicalRequirementEntity {
  final String id;
  final String name;
  final String description;
  final String technologicalRequirementType;

  TechnologicalRequirementEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.technologicalRequirementType,
  });

  factory TechnologicalRequirementEntity.fromJson(Map<String, dynamic> json) {
    return TechnologicalRequirementEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      technologicalRequirementType: json['technologicalRequirementType'] ?? '',
    );
  }
}

class LearnerStylePreferenceEntity {
  final String id;
  final String name;
  final String description;

  LearnerStylePreferenceEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory LearnerStylePreferenceEntity.fromJson(Map<String, dynamic> json) {
    return LearnerStylePreferenceEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class TrainingProfileResponseEntity {
  final TrainingProfileEntity trainingProfile;
  final String code;
  final String message;

  TrainingProfileResponseEntity({
    required this.trainingProfile,
    required this.code,
    required this.message,
  });

  factory TrainingProfileResponseEntity.fromJson(Map<String, dynamic> json) {
    return TrainingProfileResponseEntity(
      trainingProfile: TrainingProfileEntity.fromJson(
        json['trainingProfile'] ?? {},
      ),
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
