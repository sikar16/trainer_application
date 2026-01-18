class ContentEntity {
  final String id;
  final String name;
  final String description;
  final String contentLevel;
  final String contentFileType;
  final String? link;
  final String? referenceLink;
  final String? rejectionReason;
  final String contentStatus;
  final ContentDeveloperEntity contentDeveloper;
  final String? moduleName;
  final String? lessonName;
  final String? assessmentName;

  const ContentEntity({
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
}

class ContentDeveloperEntity {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String email;
  final String? username;
  final RoleEntity role;
  final String? profilePictureUrl;
  final bool deactivated;
  final bool emailVerified;
  final bool phoneVerified;

  const ContentDeveloperEntity({
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
}

class RoleEntity {
  final String name;
  final String colorCode;

  const RoleEntity({required this.name, required this.colorCode});
}

class ContentResponseEntity {
  final List<ContentEntity> contents;
  final int totalPages;
  final int pageSize;
  final String message;
  final int currentPage;
  final int totalElements;

  const ContentResponseEntity({
    required this.contents,
    required this.totalPages,
    required this.pageSize,
    required this.message,
    required this.currentPage,
    required this.totalElements,
  });
}
