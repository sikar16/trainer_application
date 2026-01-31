import '../../domain/entities/application_entity.dart';

class ApplicationModel extends ApplicationResponseEntity {
  ApplicationModel({
    required super.applications,
    required super.totalPages,
    required super.totalElements,
    required super.code,
    required super.message,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
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

  Map<String, dynamic> toJson() {
    return {
      'applications': applications.map((application) => application.toJson()).toList(),
      'totalPages': totalPages,
      'totalElements': totalElements,
      'code': code,
      'message': message,
    };
  }
}

extension ApplicationEntityExtension on ApplicationEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reason': reason,
      'job': job.toJson(),
      'trainer': trainer.toJson(),
      'status': status,
      'applicationType': applicationType,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

extension JobEntityExtension on JobEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'deadlineDate': deadlineDate.toIso8601String(),
      'numberOfSessions': numberOfSessions,
      'applicantsRequired': applicantsRequired,
      'status': status,
    };
  }
}

extension TrainerEntityExtension on TrainerEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'faydaId': faydaId,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'language': language.toJson(),
      'zone': zone.toJson(),
      'city': city,
      'woreda': woreda,
      'houseNumber': houseNumber,
      'location': location,
      'academicLevel': academicLevel.toJson(),
      'trainingTags': trainingTags.map((tag) => tag.toJson()).toList(),
      'experienceYears': experienceYears,
      'coursesTaught': coursesTaught,
      'certifications': certifications,
    };
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

extension ZoneEntityExtension on ZoneEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'region': region.toJson(),
      'alternateNames': alternateNames,
    };
  }
}

extension RegionEntityExtension on RegionEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'alternateNames': alternateNames,
      'country': country.toJson(),
    };
  }
}

extension CountryEntityExtension on CountryEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

extension AcademicLevelEntityExtension on AcademicLevelEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'alternateNames': alternateNames,
    };
  }
}

extension TrainingTagEntityExtension on TrainingTagEntity {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
