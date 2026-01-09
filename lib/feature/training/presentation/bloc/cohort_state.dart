import '../../domain/entities/cohort_entity.dart';

abstract class CohortState {}

class CohortInitial extends CohortState {}

class CohortLoading extends CohortState {}

class CohortLoaded extends CohortState {
  final CohortListEntity cohortList;

  CohortLoaded(this.cohortList);
}

class CohortError extends CohortState {
  final String message;

  CohortError(this.message);
}
