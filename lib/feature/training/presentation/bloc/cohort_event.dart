abstract class CohortEvent {}

class GetCohortsEvent extends CohortEvent {
  final String trainingId;
  final int page;
  final int pageSize;

  GetCohortsEvent({
    required this.trainingId,
    this.page = 1,
    this.pageSize = 100,
  });
}
