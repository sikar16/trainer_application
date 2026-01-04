class UserEntity {
  final String email;
  final String role;
  final String token;
  final bool isFirstTimeLogin;

  UserEntity({
    required this.email,
    required this.role,
    required this.token,
    required this.isFirstTimeLogin,
  });
}
