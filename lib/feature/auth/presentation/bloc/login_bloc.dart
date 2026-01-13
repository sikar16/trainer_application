import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../../../core/storage/storage_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await loginUseCase(event.email, event.password);
        await StorageService.saveToken(user.token);
        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure("Invalid email or password"));
      }
    });
  }
}
