part of 'training_profile_bloc.dart';

abstract class TrainingProfileState extends Equatable {
  const TrainingProfileState();

  @override
  List<Object> get props => [];
}

class TrainingProfileInitial extends TrainingProfileState {}

class TrainingProfileLoading extends TrainingProfileState {}

class TrainingProfileLoaded extends TrainingProfileState {
  final TrainingProfileResponseEntity trainingProfile;

  const TrainingProfileLoaded(this.trainingProfile);

  @override
  List<Object> get props => [trainingProfile];
}

class TrainingProfileError extends TrainingProfileState {
  final String message;

  const TrainingProfileError(this.message);

  @override
  List<Object> get props => [message];
}
