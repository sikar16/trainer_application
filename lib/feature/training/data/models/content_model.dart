import '../../domain/entities/content_entity.dart';

class ContentModel {
  final String id;
  final String name;
  final String description;
  final String contentLevel;
  final String contentFileType;
  final String? link;
  final String? referenceLink;
  final String? rejectionReason;
  final String contentStatus;
  final ContentDeveloperModel contentDeveloper;
  final String? moduleName;
  final String? lessonName;
  final String? assessmentName;

  const ContentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.contentLevel,
    required this.contentFileType,
    this.link,
    this.referenceLink,
    this.rejectionReason,
    required this.contentStatus,
    required this.contentDeveloper,
    this.moduleName,
    this.lessonName,
    this.assessmentName,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      contentLevel: json['contentLevel'] ?? '',
      contentFileType: json['contentFileType'] ?? '',
      link: json['link'],
      referenceLink: json['referenceLink'],
      rejectionReason: json['rejectionReason'],
      contentStatus: json['contentStatus'] ?? '',
      contentDeveloper: ContentDeveloperModel.fromJson(
        json['contentDeveloper'] ?? {},
      ),
      moduleName: json['moduleName'],
      lessonName: json['lessonName'],
      assessmentName: json['assessmentName'],
    );
  }

  ContentEntity toEntity() {
    return ContentEntity(
      id: id,
      name: name,
      description: description,
      contentLevel: contentLevel,
      contentFileType: contentFileType,
      link: link,
      referenceLink: referenceLink,
      rejectionReason: rejectionReason,
      contentStatus: contentStatus,
      contentDeveloper: contentDeveloper.toEntity(),
      moduleName: moduleName,
      lessonName: lessonName,
      assessmentName: assessmentName,
    );
  }
}

class ContentDeveloperModel {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String email;
  final String? username;
  final RoleModel role;
  final String? profilePictureUrl;
  final bool deactivated;
  final bool emailVerified;
  final bool phoneVerified;

  const ContentDeveloperModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    required this.email,
    this.username,
    required this.role,
    this.profilePictureUrl,
    required this.deactivated,
    required this.emailVerified,
    required this.phoneVerified,
  });

  factory ContentDeveloperModel.fromJson(Map<String, dynamic> json) {
    return ContentDeveloperModel(
      id: json['id'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'] ?? '',
      username: json['username'],
      role: RoleModel.fromJson(json['role'] ?? {}),
      profilePictureUrl: json['profilePictureUrl'],
      deactivated: json['deactivated'] ?? false,
      emailVerified: json['emailVerified'] ?? false,
      phoneVerified: json['phoneVerified'] ?? false,
    );
  }

  ContentDeveloperEntity toEntity() {
    return ContentDeveloperEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      username: username,
      role: role.toEntity(),
      profilePictureUrl: profilePictureUrl,
      deactivated: deactivated,
      emailVerified: emailVerified,
      phoneVerified: phoneVerified,
    );
  }
}

class RoleModel {
  final String name;
  final String colorCode;

  const RoleModel({required this.name, required this.colorCode});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'] ?? '',
      colorCode: json['colorCode'] ?? '',
    );
  }

  RoleEntity toEntity() {
    return RoleEntity(name: name, colorCode: colorCode);
  }
}

class ContentResponseModel {
  final List<ContentModel> contents;
  final int totalPages;
  final int pageSize;
  final String message;
  final int currentPage;
  final int totalElements;

  const ContentResponseModel({
    required this.contents,
    required this.totalPages,
    required this.pageSize,
    required this.message,
    required this.currentPage,
    required this.totalElements,
  });

  factory ContentResponseModel.fromJson(Map<String, dynamic> json) {
    return ContentResponseModel(
      contents:
          (json['contents'] as List<dynamic>?)
              ?.map((e) => ContentModel.fromJson(e))
              .toList() ??
          [],
      totalPages: json['totalPages'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      message: json['message'] ?? '',
      currentPage: json['currentPage'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
    );
  }

  ContentResponseEntity toEntity() {
    return ContentResponseEntity(
      contents: contents.map((e) => e.toEntity()).toList(),
      totalPages: totalPages,
      pageSize: pageSize,
      message: message,
      currentPage: currentPage,
      totalElements: totalElements,
    );
  }
}
