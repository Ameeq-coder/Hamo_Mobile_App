class HomeUser {
  final String id;
  final String email;
  final String userType;

  HomeUser({required this.id, required this.email, required this.userType});

  factory HomeUser.fromJson(Map<String, dynamic> json) {
    return HomeUser(
      id: json['id'],
      email: json['email'],
      userType: json['userType'],
    );
  }
}

class HomeUserDetail {
  final String id;
  final String userId;
  final String name;
  final String dob;
  final String phone;
  final String address;
  final String imageUrl;
  final HomeUser user;

  HomeUserDetail({
    required this.id,
    required this.userId,
    required this.name,
    required this.dob,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.user,
  });

  factory HomeUserDetail.fromJson(Map<String, dynamic> json) {
    return HomeUserDetail(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      dob: json['dob'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      user: HomeUser.fromJson(json['user']),
    );
  }
}
