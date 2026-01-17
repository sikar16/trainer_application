class AudienceProfileEntity {
  final String id;
  final String trainingId;
  final LearnerLevelEntity learnerLevel;
  final EducationLevelEntity educationLevel;
  final LanguageEntity language;
  final List<dynamic> specificCoursesList;
  final dynamic certifications;
  final dynamic licenses;
  final WorkExperienceEntity workExperience;
  final List<dynamic> specificPrerequisites;

  AudienceProfileEntity({
    required this.id,
    required this.trainingId,
    required this.learnerLevel,
    required this.educationLevel,
    required this.language,
    required this.specificCoursesList,
    required this.certifications,
    required this.licenses,
    required this.workExperience,
    required this.specificPrerequisites,
  });

  factory AudienceProfileEntity.fromJson(Map<String, dynamic> json) {
    return AudienceProfileEntity(
      id: json['id'] ?? '',
      trainingId: json['trainingId'] ?? '',
      learnerLevel: LearnerLevelEntity.fromJson(json['learnerLevel'] ?? {}),
      educationLevel: EducationLevelEntity.fromJson(
        json['educationLevel'] ?? {},
      ),
      language: LanguageEntity.fromJson(json['language'] ?? {}),
      specificCoursesList: json['specificCoursesList'] ?? [],
      certifications: json['certifications'],
      licenses: json['licenses'],
      workExperience: WorkExperienceEntity.fromJson(
        json['workExperience'] ?? {},
      ),
      specificPrerequisites: json['specificPrerequisites'] ?? [],
    );
  }
}

class LearnerLevelEntity {
  final String id;
  final String name;
  final String description;

  LearnerLevelEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory LearnerLevelEntity.fromJson(Map<String, dynamic> json) {
    return LearnerLevelEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class EducationLevelEntity {
  final String id;
  final String name;
  final String description;

  EducationLevelEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory EducationLevelEntity.fromJson(Map<String, dynamic> json) {
    return EducationLevelEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class LanguageEntity {
  final String id;
  final String name;
  final String description;
  final Map<String, String>? alternateNames;

  LanguageEntity({
    required this.id,
    required this.name,
    required this.description,
    this.alternateNames,
  });

  factory LanguageEntity.fromJson(Map<String, dynamic> json) {
    return LanguageEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      alternateNames: Map<String, String>.from(json['alternateNames'] ?? {}),
    );
  }
}

class WorkExperienceEntity {
  final String id;
  final String name;
  final String description;

  WorkExperienceEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory WorkExperienceEntity.fromJson(Map<String, dynamic> json) {
    return WorkExperienceEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class AudienceProfileResponseEntity {
  final AudienceProfileEntity audienceProfile;
  final String code;
  final String message;

  AudienceProfileResponseEntity({
    required this.audienceProfile,
    required this.code,
    required this.message,
  });

  factory AudienceProfileResponseEntity.fromJson(Map<String, dynamic> json) {
    return AudienceProfileResponseEntity(
      audienceProfile: AudienceProfileEntity.fromJson(
        json['audienceProfile'] ?? {},
      ),
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
