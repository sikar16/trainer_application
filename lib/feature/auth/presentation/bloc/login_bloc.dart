import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../../../core/storage/storage_service.dart';
import '../../../../feature/profile/data/datasources/profile_remote_data_source.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await loginUseCase(event.email, event.password);

        // Save token to local storage
        await StorageService.saveToken(user.token);

        // Fetch and save profile data
        try {
          final profileDataSource = ProfileRemoteDataSource();
          final profile = await profileDataSource.getProfile();

          // Save profile data to local storage
          await StorageService.saveUserData(profile.toJson());
        } catch (e) {
          // If profile fetch fails, still proceed with login
          // but log the error
          print('Failed to fetch profile: $e');
        }

        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure("Invalid email or password"));
      }
    });
  }
}
