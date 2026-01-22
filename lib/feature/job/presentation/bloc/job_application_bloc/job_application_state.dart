part of 'job_application_bloc.dart';

abstract class JobApplicationState extends Equatable {
  const JobApplicationState();

  @override
  List<Object> get props => [];
}

class JobApplicationInitial extends JobApplicationState {}

class JobApplicationLoading extends JobApplicationState {}

class JobApplicationSuccess extends JobApplicationState {}

class JobApplicationFailure extends JobApplicationState {
  final String message;

  const JobApplicationFailure(this.message);

  @override
  List<Object> get props => [message];
}
