import 'profile_model.dart';

class EditProfileResponseModel {
  final String code;
  final bool isPhoneChanged;
  final String message;
  final ProfileModel user;
  final bool isEmailChanged;

  EditProfileResponseModel({
    required this.code,
    required this.isPhoneChanged,
    required this.message,
    required this.user,
    required this.isEmailChanged,
  });

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return EditProfileResponseModel(
      code: json['code']?.toString() ?? '',
      isPhoneChanged: json['isPhoneChanged'] as bool? ?? false,
      message: json['message']?.toString() ?? '',
      user: ProfileModel.fromJson(json['user'] as Map<String, dynamic>),
      isEmailChanged: json['isEmailChanged'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'isPhoneChanged': isPhoneChanged,
      'message': message,
      'user': user.toJson(),
      'isEmailChanged': isEmailChanged,
    };
  }
}
