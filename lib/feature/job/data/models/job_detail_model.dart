import '../../domain/entities/job_detail_entity.dart';

class JobDetailResponseModel {
  final String code;
  final String message;
  final JobDetailModel job;

  JobDetailResponseModel({
    required this.code,
    required this.message,
    required this.job,
  });

  factory JobDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return JobDetailResponseModel(
      code: json['code'] ?? '',
      message: json['message'] ?? '',
      job: JobDetailModel.fromJson(json['job'] ?? {}),
    );
  }

  JobDetailResponseEntity toEntity() {
    return JobDetailResponseEntity(
      code: code,
      message: message,
      job: job.toEntity(),
    );
  }
}

class JobDetailModel {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String deadlineDate;
  final int numberOfSessions;
  final int applicantsRequired;
  final String status;
  final double mainTrainerTotalCompensation;
  final double assistantTrainerTotalCompensation;
  final List<SessionModel> sessions;

  JobDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadlineDate,
    required this.numberOfSessions,
    required this.applicantsRequired,
    required this.status,
    required this.mainTrainerTotalCompensation,
    required this.assistantTrainerTotalCompensation,
    required this.sessions,
  });

  factory JobDetailModel.fromJson(Map<String, dynamic> json) {
    return JobDetailModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
      deadlineDate: json['deadlineDate'] ?? '',
      numberOfSessions: json['numberOfSessions'] ?? 0,
      applicantsRequired: json['applicantsRequired'] ?? 0,
      status: json['status'] ?? '',
      mainTrainerTotalCompensation: (json['mainTrainerTotalCompensation'] ?? 0)
          .toDouble(),
      assistantTrainerTotalCompensation:
          (json['assistantTrainerTotalCompensation'] ?? 0).toDouble(),
      sessions:
          (json['sessions'] as List<dynamic>?)
              ?.map((session) => SessionModel.fromJson(session))
              .toList() ??
          [],
    );
  }

  JobDetailEntity toEntity() {
    return JobDetailEntity(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      deadlineDate: deadlineDate,
      numberOfSessions: numberOfSessions,
      applicantsRequired: applicantsRequired,
      status: status,
      mainTrainerTotalCompensation: mainTrainerTotalCompensation,
      assistantTrainerTotalCompensation: assistantTrainerTotalCompensation,
      sessions: sessions.map((session) => session.toEntity()).toList(),
    );
  }
}

class SessionModel {
  final String id;
  final String name;
  final CohortModel cohort;
  final List<LessonModel> lessons;
  final String deliveryMethod;
  final String startDate;
  final String endDate;
  final int numberOfStudents;
  final TrainingVenueModel trainingVenue;
  final bool meetsRequirement;
  final String requirementRemark;
  final String trainerCompensationType;
  final double trainerCompensationAmount;
  final int numberOfAssistantTrainers;
  final String assistantTrainerCompensationType;
  final double assistantTrainerCompensationAmount;
  final String status;
  final bool first;
  final bool last;

  SessionModel({
    required this.id,
    required this.name,
    required this.cohort,
    required this.lessons,
    required this.deliveryMethod,
    required this.startDate,
    required this.endDate,
    required this.numberOfStudents,
    required this.trainingVenue,
    required this.meetsRequirement,
    required this.requirementRemark,
    required this.trainerCompensationType,
    required this.trainerCompensationAmount,
    required this.numberOfAssistantTrainers,
    required this.assistantTrainerCompensationType,
    required this.assistantTrainerCompensationAmount,
    required this.status,
    required this.first,
    required this.last,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cohort: CohortModel.fromJson(json['cohort'] ?? {}),
      lessons:
          (json['lessons'] as List<dynamic>?)
              ?.map((lesson) => LessonModel.fromJson(lesson))
              .toList() ??
          [],
      deliveryMethod: json['deliveryMethod'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      numberOfStudents: json['numberOfStudents'] ?? 0,
      trainingVenue: TrainingVenueModel.fromJson(json['trainingVenue'] ?? {}),
      meetsRequirement: json['meetsRequirement'] ?? false,
      requirementRemark: json['requirementRemark'] ?? '',
      trainerCompensationType: json['trainerCompensationType'] ?? '',
      trainerCompensationAmount: (json['trainerCompensationAmount'] ?? 0)
          .toDouble(),
      numberOfAssistantTrainers: json['numberOfAssistantTrainers'] ?? 0,
      assistantTrainerCompensationType:
          json['assistantTrainerCompensationType'] ?? '',
      assistantTrainerCompensationAmount:
          (json['assistantTrainerCompensationAmount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      first: json['first'] ?? false,
      last: json['last'] ?? false,
    );
  }

  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      name: name,
      cohort: cohort.toEntity(),
      lessons: lessons.map((lesson) => lesson.toEntity()).toList(),
      deliveryMethod: deliveryMethod,
      startDate: startDate,
      endDate: endDate,
      numberOfStudents: numberOfStudents,
      trainingVenue: trainingVenue.toEntity(),
      meetsRequirement: meetsRequirement,
      requirementRemark: requirementRemark,
      trainerCompensationType: trainerCompensationType,
      trainerCompensationAmount: trainerCompensationAmount,
      numberOfAssistantTrainers: numberOfAssistantTrainers,
      assistantTrainerCompensationType: assistantTrainerCompensationType,
      assistantTrainerCompensationAmount: assistantTrainerCompensationAmount,
      status: status,
      first: first,
      last: last,
    );
  }
}

class CohortModel {
  final String id;
  final String name;
  final String description;
  final List<String> tags;
  final String trainingTitle;
  final String parentCohortName;

  CohortModel({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.trainingTitle,
    required this.parentCohortName,
  });

  factory CohortModel.fromJson(Map<String, dynamic> json) {
    return CohortModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag.toString())
              .toList() ??
          [],
      trainingTitle: json['trainingTitle'] ?? '',
      parentCohortName: json['parentCohortName'] ?? '',
    );
  }

  CohortEntity toEntity() {
    return CohortEntity(
      id: id,
      name: name,
      description: description,
      tags: tags,
      trainingTitle: trainingTitle,
      parentCohortName: parentCohortName,
    );
  }
}

class LessonModel {
  final String id;
  final String name;
  final String objective;
  final String description;
  final double duration;
  final String durationType;

  LessonModel({
    required this.id,
    required this.name,
    required this.objective,
    required this.description,
    required this.duration,
    required this.durationType,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      objective: json['objective'] ?? '',
      description: json['description'] ?? '',
      duration: (json['duration'] ?? 0).toDouble(),
      durationType: json['durationType'] ?? '',
    );
  }

  LessonEntity toEntity() {
    return LessonEntity(
      id: id,
      name: name,
      objective: objective,
      description: description,
      duration: duration,
      durationType: durationType,
    );
  }
}

class TrainingVenueModel {
  final String id;
  final String name;
  final ZoneModel zone;
  final String? city;
  final String location;
  final String woreda;
  final int seatingCapacity;
  final int standingCapacity;
  final int roomCount;
  final double totalArea;
  final bool hasAccessibility;
  final String accessibilityFeatures;
  final bool hasParkingSpace;
  final int? parkingCapacity;
  final bool isActive;

  TrainingVenueModel({
    required this.id,
    required this.name,
    required this.zone,
    this.city,
    required this.location,
    required this.woreda,
    required this.seatingCapacity,
    required this.standingCapacity,
    required this.roomCount,
    required this.totalArea,
    required this.hasAccessibility,
    required this.accessibilityFeatures,
    required this.hasParkingSpace,
    this.parkingCapacity,
    required this.isActive,
  });

  factory TrainingVenueModel.fromJson(Map<String, dynamic> json) {
    return TrainingVenueModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      zone: ZoneModel.fromJson(json['zone'] ?? {}),
      city: json['city'],
      location: json['location'] ?? '',
      woreda: json['woreda'] ?? '',
      seatingCapacity: json['seatingCapacity'] ?? 0,
      standingCapacity: json['standingCapacity'] ?? 0,
      roomCount: json['roomCount'] ?? 0,
      totalArea: (json['totalArea'] ?? 0).toDouble(),
      hasAccessibility: json['hasAccessibility'] ?? false,
      accessibilityFeatures: json['accessibilityFeatures'] ?? '',
      hasParkingSpace: json['hasParkingSpace'] ?? false,
      parkingCapacity: json['parkingCapacity'],
      isActive: json['isActive'] ?? false,
    );
  }

  TrainingVenueEntity toEntity() {
    return TrainingVenueEntity(
      id: id,
      name: name,
      zone: zone.toEntity(),
      city: city ?? '',
      location: location,
      woreda: woreda,
      seatingCapacity: seatingCapacity,
      standingCapacity: standingCapacity,
      roomCount: roomCount,
      totalArea: totalArea,
      hasAccessibility: hasAccessibility,
      accessibilityFeatures: accessibilityFeatures,
      hasParkingSpace: hasParkingSpace,
      parkingCapacity: parkingCapacity,
      isActive: isActive,
    );
  }
}

class ZoneModel {
  final String id;
  final String name;
  final String description;
  final RegionModel region;

  ZoneModel({
    required this.id,
    required this.name,
    required this.description,
    required this.region,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      region: RegionModel.fromJson(json['region'] ?? {}),
    );
  }

  ZoneEntity toEntity() {
    return ZoneEntity(
      id: id,
      name: name,
      description: description,
      region: region.toEntity(),
    );
  }
}

class RegionModel {
  final String id;
  final String name;
  final String description;
  final CountryModel country;

  RegionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.country,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      country: CountryModel.fromJson(json['country'] ?? {}),
    );
  }

  RegionEntity toEntity() {
    return RegionEntity(
      id: id,
      name: name,
      description: description,
      country: country.toEntity(),
    );
  }
}

class CountryModel {
  final String id;
  final String name;
  final String description;

  CountryModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  CountryEntity toEntity() {
    return CountryEntity(id: id, name: name, description: description);
  }
}
