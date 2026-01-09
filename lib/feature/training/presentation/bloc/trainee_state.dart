import '../../domain/entities/trainee_entity.dart';

abstract class TraineeState {}

class TraineeInitial extends TraineeState {}

class TraineeLoading extends TraineeState {}

class TraineeLoaded extends TraineeState {
  final TraineeListEntity traineeList;

  TraineeLoaded(this.traineeList);
}

class TraineeError extends TraineeState {
  final String message;

  TraineeError(this.message);
}
