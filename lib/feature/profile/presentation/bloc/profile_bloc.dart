import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../../../core/storage/storage_service.dart';
import '../../data/models/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final EditProfileUseCase editProfileUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.editProfileUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await getProfileUseCase();

        if (profile is ProfileModel) {
          await StorageService.saveUserData(profile.toJson());
        }

        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<EditProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await editProfileUseCase(event.profileData);

        if (profile is ProfileModel) {
          await StorageService.saveUserData(profile.toJson());
        }

        emit(ProfileEditSuccess(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
