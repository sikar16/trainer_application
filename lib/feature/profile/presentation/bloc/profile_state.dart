import '../../domain/entities/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  ProfileLoaded(this.profile);
}

class ProfileEditSuccess extends ProfileState {
  final ProfileEntity profile;
  final String message;
  final bool isPhoneChanged;
  final bool isEmailChanged;

  ProfileEditSuccess(
    this.profile,
    this.message,
    this.isPhoneChanged,
    this.isEmailChanged,
  );
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class LogoutSuccess extends ProfileState {}
