import 'training_entity.dart';

class TraineeEntity {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String contactPhone;
  final String dateOfBirth;
  final String gender;
  final ZoneEntity? zone;
  final String? city;
  final String? woreda;
  final String? houseNumber;
  final int numberOfChildren;
  final LanguageEntity? language;
  final AcademicLevelEntity? academicLevel;
  final String? fieldOfStudy;
  final bool hasSmartphone;
  final List<String> digitalDevices;
  final bool hasTrainingExperience;
  final String? trainingExperienceDescription;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelationship;
  final List<String> disabilities;
  final List<String> marginalizedGroups;
  final String cohortName;
  final bool didSignConsentForm;
  final String? consentFormUrl;
  final String? pendingTraineeId;
  final String? idType;
  final String? frontIdUrl;
  final String? backIdUrl;
  final String? signatureUrl;
  final String? certificateUrl;
  final bool certificateSmsSent;
  final bool selfRegistered;
  final bool fromEdge;

  TraineeEntity({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.contactPhone,
    required this.dateOfBirth,
    required this.gender,
    this.zone,
    this.city,
    this.woreda,
    this.houseNumber,
    required this.numberOfChildren,
    this.language,
    this.academicLevel,
    this.fieldOfStudy,
    required this.hasSmartphone,
    required this.digitalDevices,
    required this.hasTrainingExperience,
    this.trainingExperienceDescription,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelationship,
    required this.disabilities,
    required this.marginalizedGroups,
    required this.cohortName,
    required this.didSignConsentForm,
    this.consentFormUrl,
    this.pendingTraineeId,
    this.idType,
    this.frontIdUrl,
    this.backIdUrl,
    this.signatureUrl,
    this.certificateUrl,
    required this.certificateSmsSent,
    required this.selfRegistered,
    required this.fromEdge,
  });

  String get fullName {
    if (middleName != null && middleName!.isNotEmpty) {
      return '$firstName $middleName $lastName';
    }
    return '$firstName $lastName';
  }
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

class TraineeListEntity {
  final List<TraineeEntity> trainees;
  final int totalPages;
  final int pageSize;
  final String message;
  final int currentPage;
  final int totalElements;

  TraineeListEntity({
    required this.trainees,
    required this.totalPages,
    required this.pageSize,
    required this.message,
    required this.currentPage,
    required this.totalElements,
  });
}
