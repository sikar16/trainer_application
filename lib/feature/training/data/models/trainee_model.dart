import '../../domain/entities/trainee_entity.dart';
import 'training_model.dart';

class TraineeModel extends TraineeEntity {
  TraineeModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required super.contactPhone,
    required super.dateOfBirth,
    required super.gender,
    super.zone,
    super.city,
    super.woreda,
    super.houseNumber,
    required super.numberOfChildren,
    super.language,
    super.academicLevel,
    super.fieldOfStudy,
    required super.hasSmartphone,
    required super.digitalDevices,
    required super.hasTrainingExperience,
    super.trainingExperienceDescription,
    required super.emergencyContactName,
    required super.emergencyContactPhone,
    required super.emergencyContactRelationship,
    required super.disabilities,
    required super.marginalizedGroups,
    required super.cohortName,
    required super.didSignConsentForm,
    super.consentFormUrl,
    super.pendingTraineeId,
    super.idType,
    super.frontIdUrl,
    super.backIdUrl,
    super.signatureUrl,
    super.certificateUrl,
    required super.certificateSmsSent,
    required super.selfRegistered,
    required super.fromEdge,
  });

  factory TraineeModel.fromJson(Map<String, dynamic> json) {
    return TraineeModel(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      middleName: json['middleName']?.toString(),
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      contactPhone: json['contactPhone']?.toString() ?? '',
      dateOfBirth: json['dateOfBirth']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      zone: json['zone'] != null
          ? ZoneModel.fromJson(json['zone'] as Map<String, dynamic>)
          : null,
      city: json['city']?.toString(),
      woreda: json['woreda']?.toString(),
      houseNumber: json['houseNumber']?.toString(),
      numberOfChildren: json['numberOfChildren'] as int? ?? 0,
      language: json['language'] != null
          ? LanguageModel.fromJson(json['language'] as Map<String, dynamic>)
          : null,
      academicLevel: json['academicLevel'] != null
          ? AcademicLevelModel.fromJson(
              json['academicLevel'] as Map<String, dynamic>,
            )
          : null,
      fieldOfStudy: json['fieldOfStudy']?.toString(),
      hasSmartphone: json['hasSmartphone'] as bool? ?? false,
      digitalDevices:
          (json['digitalDevices'] as List<dynamic>?)
              ?.map((device) => device?.toString() ?? '')
              .where((device) => device.isNotEmpty)
              .toList() ??
          [],
      hasTrainingExperience: json['hasTrainingExperience'] as bool? ?? false,
      trainingExperienceDescription: json['trainingExperienceDescription']
          ?.toString(),
      emergencyContactName: json['emergencyContactName']?.toString() ?? '',
      emergencyContactPhone: json['emergencyContactPhone']?.toString() ?? '',
      emergencyContactRelationship:
          json['emergencyContactRelationship']?.toString() ?? '',
      disabilities:
          (json['disabilities'] as List<dynamic>?)
              ?.map((disability) => disability?.toString() ?? '')
              .where((disability) => disability.isNotEmpty)
              .toList() ??
          [],
      marginalizedGroups:
          (json['marginalizedGroups'] as List<dynamic>?)
              ?.map((group) => group?.toString() ?? '')
              .where((group) => group.isNotEmpty)
              .toList() ??
          [],
      cohortName: json['cohortName']?.toString() ?? '',
      didSignConsentForm: json['didSignConsentForm'] as bool? ?? false,
      consentFormUrl: json['consentFormUrl']?.toString(),
      pendingTraineeId: json['pendingTraineeId']?.toString(),
      idType: json['idType']?.toString(),
      frontIdUrl: json['frontIdUrl']?.toString(),
      backIdUrl: json['backIdUrl']?.toString(),
      signatureUrl: json['signatureUrl']?.toString(),
      certificateUrl: json['certificateUrl']?.toString(),
      certificateSmsSent: json['certificateSmsSent'] as bool? ?? false,
      selfRegistered: json['selfRegistered'] as bool? ?? false,
      fromEdge: json['fromEdge'] as bool? ?? false,
    );
  }
}

class LanguageModel extends LanguageEntity {
  LanguageModel({
    required super.id,
    required super.name,
    required super.description,
    required super.alternateNames,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      alternateNames: Map<String, String>.from(
        (json['alternateNames'] as Map<String, dynamic>? ?? {}).map(
          (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
        ),
      ),
    );
  }
}

class AcademicLevelModel extends AcademicLevelEntity {
  AcademicLevelModel({
    required super.id,
    required super.name,
    required super.description,
    required super.alternateNames,
  });

  factory AcademicLevelModel.fromJson(Map<String, dynamic> json) {
    return AcademicLevelModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      alternateNames: Map<String, String>.from(
        (json['alternateNames'] as Map<String, dynamic>? ?? {}).map(
          (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
        ),
      ),
    );
  }
}

class TraineeListModel extends TraineeListEntity {
  TraineeListModel({
    required super.trainees,
    required super.totalPages,
    required super.pageSize,
    required super.message,
    required super.currentPage,
    required super.totalElements,
  });

  factory TraineeListModel.fromJson(Map<String, dynamic> json) {
    return TraineeListModel(
      trainees:
          (json['trainees'] as List<dynamic>?)
              ?.map(
                (trainee) => TraineeModel.fromJson(
                  trainee as Map<String, dynamic>? ?? {},
                ),
              )
              .toList() ??
          [],
      totalPages: json['totalPages'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 10,
      message: json['message']?.toString() ?? '',
      currentPage: json['currentPage'] as int? ?? 1,
      totalElements: json['totalElements'] as int? ?? 0,
    );
  }
}
