class CohortEntity {
  final String id;
  final String name;
  final String description;
  final List<String> tags;
  final String trainingTitle;
  final String? parentCohortName;
  final List<CohortEntity> subCohorts;

  CohortEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.trainingTitle,
    this.parentCohortName,
    required this.subCohorts,
  });
}

class CohortListEntity {
  final List<CohortEntity> cohorts;
  final int totalPages;
  final int pageSize;
  final String message;
  final int currentPage;
  final int totalElements;

  CohortListEntity({
    required this.cohorts,
    required this.totalPages,
    required this.pageSize,
    required this.message,
    required this.currentPage,
    required this.totalElements,
  });
}
