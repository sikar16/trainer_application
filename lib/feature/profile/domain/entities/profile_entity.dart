class ProfileEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String? username;
  final RoleEntity role;
  final String? profilePictureUrl;
  final TrainerEntity? trainer;
  final bool deactivated;
  final bool phoneVerified;
  final bool emailVerified;

  ProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    this.username,
    required this.role,
    this.profilePictureUrl,
    this.trainer,
    required this.deactivated,
    required this.phoneVerified,
    required this.emailVerified,
  });
}

class RoleEntity {
  final String name;
  final String colorCode;

  RoleEntity({required this.name, required this.colorCode});
}

class TrainerEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String faydaId;
  final String gender;
  final String dateOfBirth;
  final LanguageEntity language;
  final ZoneEntity zone;
  final String? city;
  final String woreda;
  final String houseNumber;
  final String location;
  final AcademicLevelEntity academicLevel;
  final List<TrainingTagEntity> trainingTags;
  final int experienceYears;
  final List<String> coursesTaught;
  final List<String> certifications;

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
    this.city,
    required this.woreda,
    required this.houseNumber,
    required this.location,
    required this.academicLevel,
    required this.trainingTags,
    required this.experienceYears,
    required this.coursesTaught,
    required this.certifications,
  });
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
}

class RegionEntity {
  final String id;
  final String name;
  final String description;
  final CountryEntity country;
  final Map<String, String> alternateNames;

  RegionEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.country,
    required this.alternateNames,
  });
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
}
