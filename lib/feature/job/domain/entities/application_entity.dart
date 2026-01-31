class ApplicationEntity {
  final String id;
  final String reason;
  final JobEntity job;
  final TrainerEntity trainer;
  final String status;
  final String applicationType;
  final DateTime createdAt;

  ApplicationEntity({
    required this.id,
    required this.reason,
    required this.job,
    required this.trainer,
    required this.status,
    required this.applicationType,
    required this.createdAt,
  });

  factory ApplicationEntity.fromJson(Map<String, dynamic> json) {
    return ApplicationEntity(
      id: json['id'] ?? '',
      reason: json['reason'] ?? '',
      job: JobEntity.fromJson(json['job'] ?? {}),
      trainer: TrainerEntity.fromJson(json['trainer'] ?? {}),
      status: json['status'] ?? '',
      applicationType: json['applicationType'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
    );
  }
}

class JobEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime deadlineDate;
  final int numberOfSessions;
  final int applicantsRequired;
  final String status;

  JobEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadlineDate,
    required this.numberOfSessions,
    required this.applicantsRequired,
    required this.status,
  });

  factory JobEntity.fromJson(Map<String, dynamic> json) {
    return JobEntity(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      deadlineDate: DateTime.parse(json['deadlineDate'] ?? ''),
      numberOfSessions: json['numberOfSessions'] ?? 0,
      applicantsRequired: json['applicantsRequired'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}

class TrainerEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String faydaId;
  final String gender;
  final DateTime dateOfBirth;
  final LanguageEntity language;
  final ZoneEntity zone;
  final dynamic city;
  final String woreda;
  final String houseNumber;
  final String location;
  final AcademicLevelEntity academicLevel;
  final List<TrainingTagEntity> trainingTags;
  final int experienceYears;
  final List<dynamic> coursesTaught;
  final List<dynamic> certifications;

  TrainerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.faydaId,
    required this.gender,
    required this.dateOfBirth,
    required this.language,
    required this.zone,
    required this.city,
    required this.woreda,
    required this.houseNumber,
    required this.location,
    required this.academicLevel,
    required this.trainingTags,
    required this.experienceYears,
    required this.coursesTaught,
    required this.certifications,
  });

  factory TrainerEntity.fromJson(Map<String, dynamic> json) {
    return TrainerEntity(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      faydaId: json['faydaId'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth'] ?? ''),
      language: LanguageEntity.fromJson(json['language'] ?? {}),
      zone: ZoneEntity.fromJson(json['zone'] ?? {}),
      city: json['city'],
      woreda: json['woreda'] ?? '',
      houseNumber: json['houseNumber'] ?? '',
      location: json['location'] ?? '',
      academicLevel: AcademicLevelEntity.fromJson(json['academicLevel'] ?? {}),
      trainingTags: (json['trainingTags'] as List<dynamic>?)
              ?.map((tag) => TrainingTagEntity.fromJson(tag))
              .toList() ??
          [],
      experienceYears: json['experienceYears'] ?? 0,
      coursesTaught: json['coursesTaught'] ?? [],
      certifications: json['certifications'] ?? [],
    );
  }
}

class LanguageEntity {
  final String id;
  final String name;
  final String description;
  final Map<String, String> alternateNames;

  LanguageEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.alternateNames,
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

class ZoneEntity {
  final String id;
  final String name;
  final String description;
  final RegionEntity region;
  final Map<String, String> alternateNames;

  ZoneEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.region,
    required this.alternateNames,
  });

  factory ZoneEntity.fromJson(Map<String, dynamic> json) {
    return ZoneEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      region: RegionEntity.fromJson(json['region'] ?? {}),
      alternateNames: Map<String, String>.from(json['alternateNames'] ?? {}),
    );
  }
}

class RegionEntity {
  final String id;
  final String name;
  final String description;
  final Map<String, String> alternateNames;
  final CountryEntity country;

  RegionEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.alternateNames,
    required this.country,
  });

  factory RegionEntity.fromJson(Map<String, dynamic> json) {
    return RegionEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      alternateNames: Map<String, String>.from(json['alternateNames'] ?? {}),
      country: CountryEntity.fromJson(json['country'] ?? {}),
    );
  }
}

class CountryEntity {
  final String id;
  final String name;
  final String description;

  CountryEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CountryEntity.fromJson(Map<String, dynamic> json) {
    return CountryEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class AcademicLevelEntity {
  final String id;
  final String name;
  final String description;
  final Map<String, String> alternateNames;

  AcademicLevelEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.alternateNames,
  });

  factory AcademicLevelEntity.fromJson(Map<String, dynamic> json) {
    return AcademicLevelEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      alternateNames: Map<String, String>.from(json['alternateNames'] ?? {}),
    );
  }
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

  factory TrainingTagEntity.fromJson(Map<String, dynamic> json) {
    return TrainingTagEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class ApplicationResponseEntity {
  final List<ApplicationEntity> applications;
  final int totalPages;
  final int totalElements;
  final String code;
  final String message;

  ApplicationResponseEntity({
    required this.applications,
    required this.totalPages,
    required this.totalElements,
    required this.code,
    required this.message,
  });

  factory ApplicationResponseEntity.fromJson(Map<String, dynamic> json) {
    return ApplicationResponseEntity(
      applications:
          (json['applications'] as List<dynamic>?)
              ?.map((application) => ApplicationEntity.fromJson(application))
              .toList() ??
          [],
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
