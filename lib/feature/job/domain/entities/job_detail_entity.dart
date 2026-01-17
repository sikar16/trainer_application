import 'package:equatable/equatable.dart';

class JobDetailEntity extends Equatable {
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
  final List<SessionEntity> sessions;

  const JobDetailEntity({
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

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    createdAt,
    deadlineDate,
    numberOfSessions,
    applicantsRequired,
    status,
    mainTrainerTotalCompensation,
    assistantTrainerTotalCompensation,
    sessions,
  ];
}

class SessionEntity extends Equatable {
  final String id;
  final String name;
  final CohortEntity cohort;
  final List<LessonEntity> lessons;
  final String deliveryMethod;
  final String startDate;
  final String endDate;
  final int numberOfStudents;
  final TrainingVenueEntity trainingVenue;
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

  const SessionEntity({
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

  @override
  List<Object?> get props => [
    id,
    name,
    cohort,
    lessons,
    deliveryMethod,
    startDate,
    endDate,
    numberOfStudents,
    trainingVenue,
    meetsRequirement,
    requirementRemark,
    trainerCompensationType,
    trainerCompensationAmount,
    numberOfAssistantTrainers,
    assistantTrainerCompensationType,
    assistantTrainerCompensationAmount,
    status,
    first,
    last,
  ];
}

class CohortEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> tags;
  final String trainingTitle;
  final String parentCohortName;

  const CohortEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.trainingTitle,
    required this.parentCohortName,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    tags,
    trainingTitle,
    parentCohortName,
  ];
}

class LessonEntity extends Equatable {
  final String id;
  final String name;
  final String objective;
  final String description;
  final double duration;
  final String durationType;

  const LessonEntity({
    required this.id,
    required this.name,
    required this.objective,
    required this.description,
    required this.duration,
    required this.durationType,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    objective,
    description,
    duration,
    durationType,
  ];
}

class TrainingVenueEntity extends Equatable {
  final String id;
  final String name;
  final ZoneEntity zone;
  final String city;
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

  const TrainingVenueEntity({
    required this.id,
    required this.name,
    required this.zone,
    required this.city,
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

  @override
  List<Object?> get props => [
    id,
    name,
    zone,
    city,
    location,
    woreda,
    seatingCapacity,
    standingCapacity,
    roomCount,
    totalArea,
    hasAccessibility,
    accessibilityFeatures,
    hasParkingSpace,
    parkingCapacity,
    isActive,
  ];
}

class ZoneEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final RegionEntity region;

  const ZoneEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.region,
  });

  @override
  List<Object?> get props => [id, name, description, region];
}

class RegionEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final CountryEntity country;

  const RegionEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, description, country];
}

class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String description;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}

class JobDetailResponseEntity extends Equatable {
  final String code;
  final String message;
  final JobDetailEntity job;

  const JobDetailResponseEntity({
    required this.code,
    required this.message,
    required this.job,
  });

  @override
  List<Object?> get props => [code, message, job];
}
