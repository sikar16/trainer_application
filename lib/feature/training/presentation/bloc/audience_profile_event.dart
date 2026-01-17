part of 'audience_profile_bloc.dart';

abstract class AudienceProfileEvent extends Equatable {
  const AudienceProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchAudienceProfile extends AudienceProfileEvent {
  final String trainingId;

  const FetchAudienceProfile(this.trainingId);

  @override
  List<Object> get props => [trainingId];
}
