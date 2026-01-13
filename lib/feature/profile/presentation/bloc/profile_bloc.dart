import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/feature/profile/domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../../../core/storage/storage_service.dart';
import '../../data/models/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final EditProfileUseCase editProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.editProfileUseCase,
    required this.logoutUseCase,
  }) : super(ProfileInitial()) {
    // -------- Get Profile --------
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await getProfileUseCase();
        // Save only if it's a ProfileModel (has toJson)
        if (profile is ProfileModel) {
          await StorageService.saveUserData(profile.toJson());
        }

        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    // -------- Edit Profile --------
    on<EditProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await editProfileUseCase(event.profileData);

        // Save only if it's a ProfileModel
        if (profile is ProfileModel) {
          await StorageService.saveUserData(profile.toJson());
        }

        emit(ProfileEditSuccess(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    //  -------- logout  -------------
    on<LogoutEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await logoutUseCase();
        await StorageService.clearAll();
        emit(LogoutSuccess());
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
