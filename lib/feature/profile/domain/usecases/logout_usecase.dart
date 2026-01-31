import '../repositories/profile_repository.dart';

class LogoutUseCase {
  final ProfileRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    try {
      return await repository.logout();
    } catch (e) {
      rethrow;
    }
  }
}
