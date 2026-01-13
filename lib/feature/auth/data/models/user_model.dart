import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.role,
    required super.token,
    required super.isFirstTimeLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      role: json['role'],
      token: json['token'],
      isFirstTimeLogin: json['isFirstTimeLogin'],
    );
  }
  // to json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'token': token,
      'isFirstTimeLogin': isFirstTimeLogin,
    };
  }
}
