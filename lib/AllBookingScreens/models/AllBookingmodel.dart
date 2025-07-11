class ServicemanDetail {
  final String imageUrl;
  final String category;
  final String location;

  ServicemanDetail({
    required this.imageUrl,
    required this.category,
    required this.location,
  });

  factory ServicemanDetail.fromJson(Map<String, dynamic> json) {
    return ServicemanDetail(
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
    );
  }
}

class Serviceman {
  final String id;
  final String email;
  final String serviceType;
  final ServicemanDetail detail;

  Serviceman({
    required this.id,
    required this.email,
    required this.serviceType,
    required this.detail,
  });

  factory Serviceman.fromJson(Map<String, dynamic> json) {
    return Serviceman(
      id: json['id'],
      email: json['email'],
      serviceType: json['serviceType'],
      detail: ServicemanDetail.fromJson(json['detail'] ?? {}),
    );
  }
}

class AllBooking {
  final String id;
  final String servicemanId;
  final String serviceManName;
  final String userId;
  final String userName;
  final String serviceType;
  final Map<String, dynamic> serviceOptions;
  final String location;
  final bool paid;
  final String status;
  final DateTime bookingDateTime;
  final Serviceman serviceman;

  AllBooking({
    required this.id,
    required this.servicemanId,
    required this.serviceManName,
    required this.userId,
    required this.userName,
    required this.serviceType,
    required this.serviceOptions,
    required this.location,
    required this.paid,
    required this.status,
    required this.bookingDateTime,
    required this.serviceman,
  });

  factory AllBooking.fromJson(Map<String, dynamic> json) {
    return AllBooking(
      id: json['id'],
      servicemanId: json['servicemanId'],
      serviceManName: json['serviceManName'],
      userId: json['userId'],
      userName: json['userName'],
      serviceType: json['serviceType'],
      serviceOptions: Map<String, dynamic>.from(json['serviceOptions']),
      location: json['location'],
      paid: json['paid'],
      status: json['status'],
      bookingDateTime: DateTime.parse(json['bookingDateTime']),
      serviceman: Serviceman.fromJson(json['serviceman']),
    );
  }
}
