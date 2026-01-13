import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      return await remoteDataSource.login(email, password);
    } catch (e) {
      // Could map to a domain-specific exception here
      rethrow;
    }
  }
}
