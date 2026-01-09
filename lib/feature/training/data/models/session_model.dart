import '../../domain/entities/session_entity.dart';
import 'cohort_model.dart';
import 'training_model.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    required super.id,
    required super.name,
    required super.cohort,
    required super.lessons,
    required super.deliveryMethod,
    required super.startDate,
    required super.endDate,
    required super.numberOfStudents,
    super.trainingVenue,
    required super.meetsRequirement,
    required super.requirementRemark,
    required super.trainerCompensationType,
    required super.trainerCompensationAmount,
    required super.numberOfAssistantTrainers,
    required super.assistantTrainerCompensationType,
    required super.assistantTrainerCompensationAmount,
    required super.status,
    super.incompletionReason,
    required super.fileUrls,
    super.trainingLink,
    required super.first,
    required super.last,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      cohort: CohortModel.fromJson(json['cohort'] as Map<String, dynamic>),
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map(
                (lesson) =>
                    LessonModel.fromJson(lesson as Map<String, dynamic>),
              )
              .toList() ??
          [],
      deliveryMethod: json['deliveryMethod'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      numberOfStudents: json['numberOfStudents'] as int? ?? 0,
      trainingVenue: json['trainingVenue'] != null
          ? TrainingVenueModel.fromJson(
              json['trainingVenue'] as Map<String, dynamic>,
            )
          : null,
      meetsRequirement: json['meetsRequirement'] as bool? ?? false,
      requirementRemark: json['requirementRemark'] as String? ?? '',
      trainerCompensationType: json['trainerCompensationType'] as String,
      trainerCompensationAmount:
          (json['trainerCompensationAmount'] as num?)?.toDouble() ?? 0.0,
      numberOfAssistantTrainers:
          json['numberOfAssistantTrainers'] as int? ?? 0,
      assistantTrainerCompensationType:
          json['assistantTrainerCompensationType'] as String,
      assistantTrainerCompensationAmount:
          (json['assistantTrainerCompensationAmount'] as num?)?.toDouble() ??
              0.0,
      status: json['status'] as String,
      incompletionReason: json['incompletionReason'] as String?,
      fileUrls: (json['fileUrls'] as List<dynamic>?)
              ?.map((url) => url as String)
              .toList() ??
          [],
      trainingLink: json['trainingLink'] as String?,
      first: json['first'] as bool? ?? false,
      last: json['last'] as bool? ?? false,
    );
  }
}

class LessonModel extends LessonEntity {
  LessonModel({
    required super.id,
    required super.name,
    required super.objective,
    required super.description,
    required super.duration,
    required super.durationType,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      name: json['name'] as String,
      objective: json['objective'] as String,
      description: json['description'] as String,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
      durationType: json['durationType'] as String,
    );
  }
}

class TrainingVenueModel extends TrainingVenueEntity {
  TrainingVenueModel({
    required super.id,
    required super.name,
    super.zone,
    super.city,
    super.location,
    super.woreda,
    super.latitude,
    super.longitude,
    required super.seatingCapacity,
    super.standingCapacity,
    required super.roomCount,
    required super.totalArea,
    required super.hasAccessibility,
    required super.accessibilityFeatures,
    required super.hasParkingSpace,
    super.parkingCapacity,
    required super.isActive,
  });

  factory TrainingVenueModel.fromJson(Map<String, dynamic> json) {
    return TrainingVenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      zone: json['zone'] != null
          ? ZoneModel.fromJson(json['zone'] as Map<String, dynamic>)
          : null,
      city: json['city'] as String?,
      location: json['location'] as String?,
      woreda: json['woreda'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      seatingCapacity: json['seatingCapacity'] as int? ?? 0,
      standingCapacity: json['standingCapacity'] as int?,
      roomCount: json['roomCount'] as int? ?? 0,
      totalArea: (json['totalArea'] as num?)?.toDouble() ?? 0.0,
      hasAccessibility: json['hasAccessibility'] as bool? ?? false,
      accessibilityFeatures:
          json['accessibilityFeatures'] as String? ?? '',
      hasParkingSpace: json['hasParkingSpace'] as bool? ?? false,
      parkingCapacity: json['parkingCapacity'] as int?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}

class SessionListModel extends SessionListEntity {
  SessionListModel({
    required super.sessions,
    required super.totalPages,
    required super.message,
    required super.totalElements,
  });

  factory SessionListModel.fromJson(Map<String, dynamic> json) {
    return SessionListModel(
      sessions: (json['sessions'] as List<dynamic>?)
              ?.map(
                (session) =>
                    SessionModel.fromJson(session as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPages: json['totalPages'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      totalElements: json['totalElements'] as int? ?? 0,
    );
  }
}
