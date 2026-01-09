abstract class TraineeEvent {}

class GetTraineesByCohortEvent extends TraineeEvent {
  final String cohortId;
  final int page;
  final int pageSize;

  GetTraineesByCohortEvent({
    required this.cohortId,
    this.page = 1,
    this.pageSize = 10,
  });
}
