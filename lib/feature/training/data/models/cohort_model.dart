import '../../domain/entities/cohort_entity.dart';

class CohortModel extends CohortEntity {
  CohortModel({
    required super.id,
    required super.name,
    required super.description,
    required super.tags,
    required super.trainingTitle,
    super.parentCohortName,
    required super.subCohorts,
  });

  factory CohortModel.fromJson(Map<String, dynamic> json) {
    return CohortModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag as String)
              .toList() ??
          [],
      trainingTitle: json['trainingTitle'] as String,
      parentCohortName: json['parentCohortName'] as String?,
      subCohorts:
          (json['subCohorts'] as List<dynamic>?)
              ?.map(
                (subCohort) =>
                    CohortModel.fromJson(subCohort as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class CohortListModel extends CohortListEntity {
  CohortListModel({
    required super.cohorts,
    required super.totalPages,
    required super.pageSize,
    required super.message,
    required super.currentPage,
    required super.totalElements,
  });

  factory CohortListModel.fromJson(Map<String, dynamic> json) {
    return CohortListModel(
      cohorts:
          (json['cohorts'] as List<dynamic>?)
              ?.map(
                (cohort) =>
                    CohortModel.fromJson(cohort as Map<String, dynamic>),
              )
              .toList() ??
          [],
      totalPages: json['totalPages'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 100,
      message: json['message'] as String? ?? '',
      currentPage: json['currentPage'] as int? ?? 1,
      totalElements: json['totalElements'] as int? ?? 0,
    );
  }
}
