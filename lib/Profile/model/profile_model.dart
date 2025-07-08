class ProfileModel {
  final String id;
  final String userId;
  final String name;
  final String dob;
  final String phone;
  final String address;
  final String imageUrl;
  final String email;
  final String userType;

  ProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.dob,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.email,
    required this.userType,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      dob: json['dob'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      email: json['user']['email'],
      userType: json['user']['userType'],
    );
  }
}
