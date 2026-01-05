import '../../domain/entities/training_entity.dart';

class TrainingModel extends TrainingEntity {
  TrainingModel({
    required super.id,
    required super.title,
    required super.rationale,
    required super.zones,
    required super.cities,
    required super.totalParticipants,
    required super.deliveryMethod,
    super.startDate,
    super.endDate,
    required super.duration,
    required super.durationType,
    required super.ageGroups,
    required super.genderPercentages,
    required super.trainingTags,
    super.certificateDescription,
    super.isEdgeProduct,
    super.productKey,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      rationale: json['rationale'] as String,
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
      genderPercentages:
          (json['genderPercentages'] as List<dynamic>?)
              ?.map(
                (gp) =>
                    GenderPercentageModel.fromJson(gp as Map<String, dynamic>),
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
