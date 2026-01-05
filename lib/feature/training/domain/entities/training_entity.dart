class TrainingEntity {
  final String id;
  final String title;
  final String rationale;
  final List<ZoneEntity> zones;
  final List<String> cities;
  final int totalParticipants;
  final String deliveryMethod;
  final String? startDate;
  final String? endDate;
  final double duration;
  final String durationType;
  final List<AgeGroupEntity> ageGroups;
  final List<GenderPercentageEntity> genderPercentages;
  final List<TrainingTagEntity> trainingTags;
  final String? certificateDescription;
  final bool? isEdgeProduct;
  final String? productKey;

  TrainingEntity({
    required this.id,
    required this.title,
    required this.rationale,
    required this.zones,
    required this.cities,
    required this.totalParticipants,
    required this.deliveryMethod,
    this.startDate,
    this.endDate,
    required this.duration,
    required this.durationType,
    required this.ageGroups,
    required this.genderPercentages,
    required this.trainingTags,
    this.certificateDescription,
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
