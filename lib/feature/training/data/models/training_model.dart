import '../../domain/entities/training_entity.dart';

class TrainingModel extends TrainingEntity {
  TrainingModel({
    required super.id,
    required super.title,
    required super.rationale,
    super.trainingType,
    required super.zones,
    required super.cities,
    required super.totalParticipants,
    required super.deliveryMethod,
    super.startDate,
    super.endDate,
    required super.duration,
    required super.durationType,
    required super.ageGroups,
    required super.economicBackgrounds,
    required super.academicQualifications,
    required super.genderPercentages,
    required super.disabilityPercentages,
    required super.marginalizedGroupPercentages,
    required super.trainingPurposes,
    required super.trainingTags,
    super.certificateDescription,
    super.companyProfile,
    super.isEdgeProduct,
    super.productKey,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      rationale: json['rationale'] as String,
      trainingType: json['trainingType'] != null
          ? TrainingTypeModel.fromJson(
              json['trainingType'] as Map<String, dynamic>,
            )
          : null,
      zones:
          (json['zones'] as List<dynamic>?)
              ?.map((zone) => ZoneModel.fromJson(zone as Map<String, dynamic>))
              .toList() ??
          [],
      cities:
          (json['cities'] as List<dynamic>?)
              ?.map((city) => city as String)
              .toList() ??
          [],
      totalParticipants: json['totalParticipants'] as int? ?? 0,
      deliveryMethod: json['deliveryMethod'] as String,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      durationType: json['durationType'] as String,
      ageGroups:
          (json['ageGroups'] as List<dynamic>?)
              ?.map(
                (ageGroup) =>
                    AgeGroupModel.fromJson(ageGroup as Map<String, dynamic>),
              )
              .toList() ??
          [],
      economicBackgrounds:
          (json['economicBackgrounds'] as List<dynamic>?)
              ?.map(
                (eb) => EconomicBackgroundModel.fromJson(
                  eb as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      academicQualifications:
          (json['academicQualifications'] as List<dynamic>?)
              ?.map(
                (aq) => AcademicQualificationModel.fromJson(
                  aq as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      genderPercentages:
          (json['genderPercentages'] as List<dynamic>?)
              ?.map(
                (gp) =>
                    GenderPercentageModel.fromJson(gp as Map<String, dynamic>),
              )
              .toList() ??
          [],
      disabilityPercentages:
          (json['disabilityPercentages'] as List<dynamic>?)
              ?.map(
                (dp) => DisabilityPercentageModel.fromJson(
                  dp as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      marginalizedGroupPercentages:
          (json['marginalizedGroupPercentages'] as List<dynamic>?)
              ?.map(
                (mgp) => MarginalizedGroupPercentageModel.fromJson(
                  mgp as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      trainingPurposes:
          (json['trainingPurposes'] as List<dynamic>?)
              ?.map(
                (tp) =>
                    TrainingPurposeModel.fromJson(tp as Map<String, dynamic>),
              )
              .toList() ??
          [],
      trainingTags:
          (json['trainingTags'] as List<dynamic>?)
              ?.map(
                (tag) => TrainingTagModel.fromJson(tag as Map<String, dynamic>),
              )
              .toList() ??
          [],
      certificateDescription: json['certificateDescription'] as String?,
      companyProfile: json['companyProfile'] != null
          ? CompanyProfileModel.fromJson(
              json['companyProfile'] as Map<String, dynamic>,
            )
          : null,
      isEdgeProduct: json['isEdgeProduct'] as bool?,
      productKey: json['productKey'] as String?,
    );
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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      region: RegionModel.fromJson(json['region'] as Map<String, dynamic>),
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>,
      ),
    );
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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>,
      ),
    );
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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class AgeGroupModel extends AgeGroupEntity {
  AgeGroupModel({
    required super.id,
    required super.name,
    required super.range,
    required super.description,
  });

  factory AgeGroupModel.fromJson(Map<String, dynamic> json) {
    return AgeGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      range: json['range'] as String,
      description: json['description'] as String,
    );
  }
}

class GenderPercentageModel extends GenderPercentageEntity {
  GenderPercentageModel({required super.gender, required super.percentage});

  factory GenderPercentageModel.fromJson(Map<String, dynamic> json) {
    return GenderPercentageModel(
      gender: json['gender'] as String,
      percentage: (json['percentage'] as num).toDouble(),
    );
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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class TrainingListModel extends TrainingListEntity {
  TrainingListModel({
    required super.trainings,
    required super.totalPages,
    required super.pageSize,
    required super.message,
    required super.currentPage,
    required super.totalElements,
  });

  factory TrainingListModel.fromJson(Map<String, dynamic> json) {
    return TrainingListModel(
      trainings:
          (json['trainings'] as List<dynamic>?)
              ?.map(
                (training) =>
                    TrainingModel.fromJson(training as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPages: json['totalPages'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 10,
      message: json['message'] as String? ?? '',
      currentPage: json['currentPage'] as int? ?? 1,
      totalElements: json['totalElements'] as int? ?? 0,
    );
  }
}

class TrainingTypeModel extends TrainingTypeEntity {
  TrainingTypeModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory TrainingTypeModel.fromJson(Map<String, dynamic> json) {
    return TrainingTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class EconomicBackgroundModel extends EconomicBackgroundEntity {
  EconomicBackgroundModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory EconomicBackgroundModel.fromJson(Map<String, dynamic> json) {
    return EconomicBackgroundModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class AcademicQualificationModel extends AcademicQualificationEntity {
  AcademicQualificationModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory AcademicQualificationModel.fromJson(Map<String, dynamic> json) {
    return AcademicQualificationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class DisabilityPercentageModel extends DisabilityPercentageEntity {
  DisabilityPercentageModel({
    required super.disability,
    required super.percentage,
  });

  factory DisabilityPercentageModel.fromJson(Map<String, dynamic> json) {
    return DisabilityPercentageModel(
      disability: json['disability'] as String,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}

class MarginalizedGroupPercentageModel
    extends MarginalizedGroupPercentageEntity {
  MarginalizedGroupPercentageModel({
    required super.group,
    required super.percentage,
  });

  factory MarginalizedGroupPercentageModel.fromJson(Map<String, dynamic> json) {
    return MarginalizedGroupPercentageModel(
      group: json['group'] as String,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}

class TrainingPurposeModel extends TrainingPurposeEntity {
  TrainingPurposeModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory TrainingPurposeModel.fromJson(Map<String, dynamic> json) {
    return TrainingPurposeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class CompanyProfileModel extends CompanyProfileEntity {
  CompanyProfileModel({
    required super.id,
    required super.name,
    required super.taxIdentificationNumber,
    required super.accreditation,
    required super.license,
    required super.businessType,
    required super.industryType,
    required super.countryOfIncorporation,
    required super.address,
    required super.phone,
    required super.websiteUrl,
    required super.numberOfEmployees,
    required super.otherDescription,
    super.logoUrl,
    required super.verificationStatus,
    required super.createdAt,
  });

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) {
    return CompanyProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      taxIdentificationNumber: json['taxIdentificationNumber'] as String,
      accreditation: json['accreditation'] as String,
      license: json['license'] as String,
      businessType: BusinessTypeModel.fromJson(
        json['businessType'] as Map<String, dynamic>,
      ),
      industryType: IndustryTypeModel.fromJson(
        json['industryType'] as Map<String, dynamic>,
      ),
      countryOfIncorporation: json['countryOfIncorporation'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      websiteUrl: json['websiteUrl'] as String,
      numberOfEmployees: json['numberOfEmployees'] as String,
      otherDescription: json['otherDescription'] as String? ?? '',
      logoUrl: json['logoUrl'] as String?,
      verificationStatus: json['verificationStatus'] as String,
      createdAt: json['createdAt'] as String,
    );
  }
}

class BusinessTypeModel extends BusinessTypeEntity {
  BusinessTypeModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory BusinessTypeModel.fromJson(Map<String, dynamic> json) {
    return BusinessTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class IndustryTypeModel extends IndustryTypeEntity {
  IndustryTypeModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory IndustryTypeModel.fromJson(Map<String, dynamic> json) {
    return IndustryTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}
