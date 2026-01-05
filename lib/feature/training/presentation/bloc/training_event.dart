abstract class TrainingEvent {}

class GetTrainingsEvent extends TrainingEvent {
  final int page;
  final int pageSize;

  GetTrainingsEvent({this.page = 1, this.pageSize = 10});
}

class GetTrainingByIdEvent extends TrainingEvent {
  final String id;

  GetTrainingByIdEvent(this.id);
}
