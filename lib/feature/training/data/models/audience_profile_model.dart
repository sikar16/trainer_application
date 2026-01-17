import '../../domain/entities/audience_profile_entity.dart';

class AudienceProfileModel extends AudienceProfileResponseEntity {
  AudienceProfileModel({
    required super.audienceProfile,
    required super.code,
    required super.message,
  });

  factory AudienceProfileModel.fromJson(Map<String, dynamic> json) {
    return AudienceProfileModel(
      audienceProfile: AudienceProfileEntity.fromJson(
        json['audienceProfile'] ?? {},
      ),
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audienceProfile': audienceProfile.toJson(),
      'code': code,
      'message': message,
    };
  }
}

extension AudienceProfileEntityExtension on AudienceProfileEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainingId': trainingId,
      'learnerLevel': learnerLevel.toJson(),
      'educationLevel': educationLevel.toJson(),
      'language': language.toJson(),
      'specificCoursesList': specificCoursesList,
      'certifications': certifications,
      'licenses': licenses,
      'workExperience': workExperience.toJson(),
      'specificPrerequisites': specificPrerequisites,
    };
  }
}

extension LearnerLevelEntityExtension on LearnerLevelEntity {
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension EducationLevelEntityExtension on EducationLevelEntity {
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}

extension LanguageEntityExtension on LanguageEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'alternateNames': alternateNames,
    };
  }
}

extension WorkExperienceEntityExtension on WorkExperienceEntity {
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
