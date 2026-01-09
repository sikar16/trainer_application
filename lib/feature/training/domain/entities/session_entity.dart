import 'cohort_entity.dart';
import 'training_entity.dart';

class SessionEntity {
  final String id;
  final String name;
  final CohortEntity cohort;
  final List<LessonEntity> lessons;
  final String deliveryMethod;
  final String startDate;
  final String endDate;
  final int numberOfStudents;
  final TrainingVenueEntity? trainingVenue;
  final bool meetsRequirement;
  final String requirementRemark;
  final String trainerCompensationType;
  final double trainerCompensationAmount;
  final int numberOfAssistantTrainers;
  final String assistantTrainerCompensationType;
  final double assistantTrainerCompensationAmount;
  final String status;
  final String? incompletionReason;
  final List<String> fileUrls;
  final String? trainingLink;
  final bool first;
  final bool last;

  SessionEntity({
    required this.id,
    required this.name,
    required this.cohort,
    required this.lessons,
    required this.deliveryMethod,
    required this.startDate,
    required this.endDate,
    required this.numberOfStudents,
    this.trainingVenue,
    required this.meetsRequirement,
    required this.requirementRemark,
    required this.trainerCompensationType,
    required this.trainerCompensationAmount,
    required this.numberOfAssistantTrainers,
    required this.assistantTrainerCompensationType,
    required this.assistantTrainerCompensationAmount,
    required this.status,
    this.incompletionReason,
    required this.fileUrls,
    this.trainingLink,
    required this.first,
    required this.last,
  });

  String get formattedDate {
    try {
      final date = DateTime.parse(startDate);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return startDate;
    }
  }

  String get formattedTime {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      final startPeriod = start.hour >= 12 ? 'PM' : 'AM';
      final endPeriod = end.hour >= 12 ? 'PM' : 'AM';
      final startHour12 = start.hour > 12 ? start.hour - 12 : (start.hour == 0 ? 12 : start.hour);
      final endHour12 = end.hour > 12 ? end.hour - 12 : (end.hour == 0 ? 12 : end.hour);
      return '$startHour12:${start.minute.toString().padLeft(2, '0')} $startPeriod - $endHour12:${end.minute.toString().padLeft(2, '0')} $endPeriod';
    } catch (e) {
      return '$startDate - $endDate';
    }
  }
}

class LessonEntity {
  final String id;
  final String name;
  final String objective;
  final String description;
  final double duration;
  final String durationType;

  LessonEntity({
    required this.id,
    required this.name,
    required this.objective,
    required this.description,
    required this.duration,
    required this.durationType,
  });
}

class TrainingVenueEntity {
  final String id;
  final String name;
  final ZoneEntity? zone;
  final String? city;
  final String? location;
  final String? woreda;
  final double? latitude;
  final double? longitude;
  final int seatingCapacity;
  final int? standingCapacity;
  final int roomCount;
  final double totalArea;
  final bool hasAccessibility;
  final String accessibilityFeatures;
  final bool hasParkingSpace;
  final int? parkingCapacity;
  final bool isActive;

  TrainingVenueEntity({
    required this.id,
    required this.name,
    this.zone,
    this.city,
    this.location,
    this.woreda,
    this.latitude,
    this.longitude,
    required this.seatingCapacity,
    this.standingCapacity,
    required this.roomCount,
    required this.totalArea,
    required this.hasAccessibility,
    required this.accessibilityFeatures,
    required this.hasParkingSpace,
    this.parkingCapacity,
    required this.isActive,
  });
}

class SessionListEntity {
  final List<SessionEntity> sessions;
  final int totalPages;
  final String message;
  final int totalElements;

  SessionListEntity({
    required this.sessions,
    required this.totalPages,
    required this.message,
    required this.totalElements,
  });
}
