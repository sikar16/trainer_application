import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    super.username,
    required super.role,
    super.profilePictureUrl,
    super.trainer,
    required super.deactivated,
    required super.phoneVerified,
    required super.emailVerified,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username'] as String?,
      role: RoleModel.fromJson(json['role'] as Map<String, dynamic>),
      profilePictureUrl: json['profilePictureUrl'] as String?,
      trainer: json['trainer'] != null
          ? TrainerModel.fromJson(json['trainer'] as Map<String, dynamic>)
          : null,
      deactivated: json['deactivated'] as bool? ?? false,
      phoneVerified: json['phoneVerified'] as bool? ?? false,
      emailVerified: json['emailVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'username': username,
      'role': (role as RoleModel).toJson(),
      'profilePictureUrl': profilePictureUrl,
      'trainer': trainer != null ? (trainer as TrainerModel).toJson() : null,
      'deactivated': deactivated,
      'phoneVerified': phoneVerified,
      'emailVerified': emailVerified,
    };
  }
}


class RoleModel extends RoleEntity {
  RoleModel({required super.name, required super.colorCode});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name']?.toString() ?? '',
      colorCode: json['colorCode']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'colorCode': colorCode};
}

class TrainerModel extends TrainerEntity {
  TrainerModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.faydaId,
    required super.gender,
    required super.dateOfBirth,
    required super.language,
    required super.zone,
    super.city,
    required super.woreda,
    required super.houseNumber,
    required super.location,
    required super.academicLevel,
    required super.trainingTags,
    required super.experienceYears,
    required super.coursesTaught,
    required super.certifications,
  });

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      faydaId: json['faydaId']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      dateOfBirth: json['dateOfBirth']?.toString() ?? '',
      language: LanguageModel.fromJson(
        json['language'] as Map<String, dynamic>,
      ),
      zone: ZoneModel.fromJson(json['zone'] as Map<String, dynamic>),
      city: json['city'] as String?,
      woreda: json['woreda']?.toString() ?? '',
      houseNumber: json['houseNumber']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      academicLevel: AcademicLevelModel.fromJson(
        json['academicLevel'] as Map<String, dynamic>,
      ),
      trainingTags:
          (json['trainingTags'] as List<dynamic>?)
              ?.map(
                (tag) => TrainingTagModel.fromJson(tag as Map<String, dynamic>),
              )
              .toList() ??
          [],
      experienceYears: json['experienceYears'] as int? ?? 0,
      coursesTaught:
          (json['coursesTaught'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      certifications:
          (json['certifications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'faydaId': faydaId,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'language': (language as LanguageModel).toJson(),
      'zone': (zone as ZoneModel).toJson(),
      'city': city,
      'woreda': woreda,
      'houseNumber': houseNumber,
      'location': location,
      'academicLevel': (academicLevel as AcademicLevelModel).toJson(),
      'trainingTags': trainingTags
          .map((tag) => (tag as TrainingTagModel).toJson())
          .toList(),
      'experienceYears': experienceYears,
      'coursesTaught': coursesTaught,
      'certifications': certifications,
    };
  }
}

class LanguageModel extends LanguageEntity {
  LanguageModel({
    required super.id,
    required super.name,
    required super.description,
    required super.alternateNames,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'alternateNames': alternateNames,
    };
  }
}

class ZoneModel extends ZoneEntity {
  ZoneModel({
    required super.id,
    required super.name,
    required super.description,
    required super.region,
    required super.alternateNames,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      region: RegionModel.fromJson(json['region'] as Map<String, dynamic>),
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'region': (region as RegionModel).toJson(),
      'alternateNames': alternateNames,
    };
  }
}

class RegionModel extends RegionEntity {
  RegionModel({
    required super.id,
    required super.name,
    required super.description,
    required super.country,
    required super.alternateNames,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'country': (country as CountryModel).toJson(),
      'alternateNames': alternateNames,
    };
  }
}

class CountryModel extends CountryEntity {
  CountryModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };
}

class AcademicLevelModel extends AcademicLevelEntity {
  AcademicLevelModel({
    required super.id,
    required super.name,
    required super.description,
    required super.alternateNames,
  });

  factory AcademicLevelModel.fromJson(Map<String, dynamic> json) {
    return AcademicLevelModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'alternateNames': alternateNames,
    };
  }
}

class TrainingTagModel extends TrainingTagEntity {
  TrainingTagModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory TrainingTagModel.fromJson(Map<String, dynamic> json) {
    return TrainingTagModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };
}
