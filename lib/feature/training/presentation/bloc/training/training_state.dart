import '../../../domain/entities/training_entity.dart';

abstract class TrainingState {}

class TrainingInitial extends TrainingState {}

class TrainingLoading extends TrainingState {}

class TrainingLoaded extends TrainingState {
  final TrainingListEntity trainingList;

  TrainingLoaded(this.trainingList);
}

class TrainingDetailLoaded extends TrainingState {
  final TrainingEntity training;

  TrainingDetailLoaded(this.training);
}

class TrainingError extends TrainingState {
  final String message;

  TrainingError(this.message);
}
