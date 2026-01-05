abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final Map<String, dynamic> profileData;

  EditProfileEvent(this.profileData);
}
