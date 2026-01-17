part of 'training_profile_bloc.dart';

abstract class TrainingProfileEvent extends Equatable {
  const TrainingProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchTrainingProfile extends TrainingProfileEvent {
  final String trainingId;

  const FetchTrainingProfile(this.trainingId);

  @override
  List<Object> get props => [trainingId];
}
