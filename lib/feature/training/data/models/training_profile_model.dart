import '../../domain/entities/training_profile_entity.dart';

class TrainingProfileModel extends TrainingProfileResponseEntity {
  TrainingProfileModel({
    required super.trainingProfile,
    required super.code,
    required super.message,
  });

  factory TrainingProfileModel.fromJson(Map<String, dynamic> json) {
    return TrainingProfileModel(
      trainingProfile: TrainingProfileEntity.fromJson(
        json['trainingProfile'] ?? {},
      ),
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trainingProfile': trainingProfile.toJson(),
      'code': code,
      'message': message,
    };
  }
}

extension TrainingProfileEntityExtension on TrainingProfileEntity {
  Map<String, dynamic> toJson() {
    return {
      'trainingId': trainingId,
      'keywords': keywords,
      'scope': scope,
      'attendanceRequirementPercentage': attendanceRequirementPercentage,
      'assessmentResultPercentage': assessmentResultPercentage,
      'alignmentsWithStandard': alignmentsWithStandard
          .map((item) => item.toJson())
          .toList(),
      'deliveryTools': deliveryTools.map((item) => item.toJson()).toList(),
      'learnerTechnologicalRequirements': learnerTechnologicalRequirements
          .map((item) => item.toJson())
          .toList(),
      'instructorTechnologicalRequirements': instructorTechnologicalRequirements
          .map((item) => item.toJson())
          .toList(),
      'priorKnowledgeList': priorKnowledgeList,
      'learnerStylePreferences': learnerStylePreferences
          .map((item) => item.toJson())
          .toList(),
      'professionalBackground': professionalBackground,
    };
  }
}

extension AlignmentWithStandardEntityExtension on AlignmentWithStandardEntity {
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension DeliveryToolEntityExtension on DeliveryToolEntity {
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension TechnologicalRequirementEntityExtension
    on TechnologicalRequirementEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'technologicalRequirementType': technologicalRequirementType,
    };
  }
}

extension LearnerStylePreferenceEntityExtension
    on LearnerStylePreferenceEntity {
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
