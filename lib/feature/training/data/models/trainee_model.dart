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
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      contactPhone: json['contactPhone'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
      zone: json['zone'] != null
          ? ZoneModel.fromJson(json['zone'] as Map<String, dynamic>)
          : null,
      city: json['city'] as String?,
      woreda: json['woreda'] as String?,
      houseNumber: json['houseNumber'] as String?,
      numberOfChildren: json['numberOfChildren'] as int? ?? 0,
      language: json['language'] != null
          ? LanguageModel.fromJson(json['language'] as Map<String, dynamic>)
          : null,
      academicLevel: json['academicLevel'] != null
          ? AcademicLevelModel.fromJson(
              json['academicLevel'] as Map<String, dynamic>,
            )
          : null,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      hasSmartphone: json['hasSmartphone'] as bool? ?? false,
      digitalDevices: (json['digitalDevices'] as List<dynamic>?)
              ?.map((device) => device as String)
              .toList() ??
          [],
      hasTrainingExperience: json['hasTrainingExperience'] as bool? ?? false,
      trainingExperienceDescription:
          json['trainingExperienceDescription'] as String?,
      emergencyContactName: json['emergencyContactName'] as String,
      emergencyContactPhone: json['emergencyContactPhone'] as String,
      emergencyContactRelationship:
          json['emergencyContactRelationship'] as String,
      disabilities: (json['disabilities'] as List<dynamic>?)
              ?.map((disability) => disability as String)
              .toList() ??
          [],
      marginalizedGroups: (json['marginalizedGroups'] as List<dynamic>?)
              ?.map((group) => group as String)
              .toList() ??
          [],
      cohortName: json['cohortName'] as String,
      didSignConsentForm: json['didSignConsentForm'] as bool? ?? false,
      consentFormUrl: json['consentFormUrl'] as String?,
      pendingTraineeId: json['pendingTraineeId'] as String?,
      idType: json['idType'] as String?,
      frontIdUrl: json['frontIdUrl'] as String?,
      backIdUrl: json['backIdUrl'] as String?,
      signatureUrl: json['signatureUrl'] as String?,
      certificateUrl: json['certificateUrl'] as String?,
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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>,
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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      alternateNames: Map<String, String>.from(
        json['alternateNames'] as Map<String, dynamic>,
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
      trainees: (json['trainees'] as List<dynamic>?)
              ?.map(
                (trainee) =>
                    TraineeModel.fromJson(trainee as Map<String, dynamic>),
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
