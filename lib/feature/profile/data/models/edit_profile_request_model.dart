class EditProfileRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  EditProfileRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return EditProfileRequestModel(
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
    );
  }
}
