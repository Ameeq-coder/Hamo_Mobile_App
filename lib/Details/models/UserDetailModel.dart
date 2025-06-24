class UserDetailModel {
  final String id;
  final String userId;
  final String name;
  final String dob;
  final String phone;
  final String address;
  final String imageUrl;

  UserDetailModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.dob,
    required this.phone,
    required this.address,
    required this.imageUrl,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      dob: json['dob'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
    );
  }
}
