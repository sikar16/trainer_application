import '../../data/models/edit_profile_request_model.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final EditProfileRequestModel profileData;

  EditProfileEvent(this.profileData);
}

class LogoutEvent extends ProfileEvent {}
