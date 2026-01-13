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

  ProfileEditSuccess(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class LogoutSuccess extends ProfileState {}
