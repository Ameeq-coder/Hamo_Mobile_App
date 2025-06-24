class UserModel {
  final String id;
  final String email;
  final String userType;

  UserModel({required this.id, required this.email, required this.userType});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      userType: json['userType'],
    );
  }
}
