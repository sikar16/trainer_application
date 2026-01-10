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

        await StorageService.saveToken(user.token);

        try {
          final profileDataSource = ProfileRemoteDataSource();
          final profile = await profileDataSource.getProfile();

          await StorageService.saveUserData(profile.toJson());
        } catch (e) {
          print("Error getting profile");
        }

        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure("Invalid email or password"));
      }
    });
  }
}
