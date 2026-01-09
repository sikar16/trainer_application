abstract class SessionEvent {}

class GetSessionsByCohortEvent extends SessionEvent {
  final String cohortId;
  final int page;
  final int pageSize;

  GetSessionsByCohortEvent({
    required this.cohortId,
    this.page = 1,
    this.pageSize = 20,
  });
}
