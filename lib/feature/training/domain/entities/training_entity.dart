class TrainingEntity {
  final String id;
  final String title;
  final String rationale;
  final TrainingTypeEntity? trainingType;
  final List<ZoneEntity> zones;
  final List<String> cities;
  final int totalParticipants;
  final String deliveryMethod;
  final String? startDate;
  final String? endDate;
  final double duration;
  final String durationType;
  final List<AgeGroupEntity> ageGroups;
  final List<EconomicBackgroundEntity> economicBackgrounds;
  final List<AcademicQualificationEntity> academicQualifications;
  final List<GenderPercentageEntity> genderPercentages;
  final List<DisabilityPercentageEntity> disabilityPercentages;
  final List<MarginalizedGroupPercentageEntity> marginalizedGroupPercentages;
  final List<TrainingPurposeEntity> trainingPurposes;
  final List<TrainingTagEntity> trainingTags;
  final String? certificateDescription;
  final CompanyProfileEntity? companyProfile;
  final bool? isEdgeProduct;
  final String? productKey;

  TrainingEntity({
    required this.id,
    required this.title,
    required this.rationale,
    this.trainingType,
    required this.zones,
    required this.cities,
    required this.totalParticipants,
    required this.deliveryMethod,
    this.startDate,
    this.endDate,
    required this.duration,
    required this.durationType,
    required this.ageGroups,
    required this.economicBackgrounds,
    required this.academicQualifications,
    required this.genderPercentages,
    required this.disabilityPercentages,
    required this.marginalizedGroupPercentages,
    required this.trainingPurposes,
    required this.trainingTags,
    this.certificateDescription,
    this.companyProfile,
    this.isEdgeProduct,
    this.productKey,
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

class AgeGroupEntity {
  final String id;
  final String name;
  final String range;
  final String description;

  AgeGroupEntity({
    required this.id,
    required this.name,
    required this.range,
    required this.description,
  });
}

class GenderPercentageEntity {
  final String gender;
  final double percentage;

  GenderPercentageEntity({required this.gender, required this.percentage});
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

class TrainingTypeEntity {
  final String id;
  final String name;
  final String description;

  TrainingTypeEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class EconomicBackgroundEntity {
  final String id;
  final String name;
  final String description;

  EconomicBackgroundEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class AcademicQualificationEntity {
  final String id;
  final String name;
  final String description;

  AcademicQualificationEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class DisabilityEntity {
  final String id;
  final String name;
  final String description;
  final Map<String, String>? alternateNames;

  DisabilityEntity({
    required this.id,
    required this.name,
    required this.description,
    this.alternateNames,
  });
}

class DisabilityPercentageEntity {
  final DisabilityEntity disability;
  final double percentage;

  DisabilityPercentageEntity({
    required this.disability,
    required this.percentage,
  });
}

class MarginalizedGroupEntity {
  final String id;
  final String name;
  final String description;
  final Map<String, String>? alternateNames;

  MarginalizedGroupEntity({
    required this.id,
    required this.name,
    required this.description,
    this.alternateNames,
  });
}

class MarginalizedGroupPercentageEntity {
  final MarginalizedGroupEntity group;
  final double percentage;

  MarginalizedGroupPercentageEntity({
    required this.group,
    required this.percentage,
  });
}

class TrainingPurposeEntity {
  final String id;
  final String name;
  final String description;

  TrainingPurposeEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class CompanyProfileEntity {
  final String id;
  final String name;
  final String taxIdentificationNumber;
  final String accreditation;
  final String license;
  final BusinessTypeEntity businessType;
  final IndustryTypeEntity industryType;
  final String countryOfIncorporation;
  final String address;
  final String phone;
  final String websiteUrl;
  final String numberOfEmployees;
  final String otherDescription;
  final String? logoUrl;
  final String verificationStatus;
  final String createdAt;

  CompanyProfileEntity({
    required this.id,
    required this.name,
    required this.taxIdentificationNumber,
    required this.accreditation,
    required this.license,
    required this.businessType,
    required this.industryType,
    required this.countryOfIncorporation,
    required this.address,
    required this.phone,
    required this.websiteUrl,
    required this.numberOfEmployees,
    required this.otherDescription,
    this.logoUrl,
    required this.verificationStatus,
    required this.createdAt,
  });
}

class BusinessTypeEntity {
  final String id;
  final String name;
  final String description;

  BusinessTypeEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class IndustryTypeEntity {
  final String id;
  final String name;
  final String description;

  IndustryTypeEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}

class TrainingListEntity {
  final List<TrainingEntity> trainings;
  final int totalPages;
  final int pageSize;
  final String message;
  final int currentPage;
  final int totalElements;

  TrainingListEntity({
    required this.trainings,
    required this.totalPages,
    required this.pageSize,
    required this.message,
    required this.currentPage,
    required this.totalElements,
  });
}
