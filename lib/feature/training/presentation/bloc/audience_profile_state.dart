part of 'audience_profile_bloc.dart';

abstract class AudienceProfileState extends Equatable {
  const AudienceProfileState();

  @override
  List<Object> get props => [];
}

class AudienceProfileInitial extends AudienceProfileState {}

class AudienceProfileLoading extends AudienceProfileState {}

class AudienceProfileLoaded extends AudienceProfileState {
  final AudienceProfileResponseEntity audienceProfile;

  const AudienceProfileLoaded(this.audienceProfile);

  @override
  List<Object> get props => [audienceProfile];
}

class AudienceProfileError extends AudienceProfileState {
  final String message;

  const AudienceProfileError(this.message);

  @override
  List<Object> get props => [message];
}
