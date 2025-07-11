class CreateBooking {
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
  final String startTime;
  final String endTime;
  final double price;

  CreateBooking({
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
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory CreateBooking.fromJson(Map<String, dynamic> json) {
    return CreateBooking(
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
      startTime: json['startTime'],
      endTime: json['endTime'],
      price: json['price'].toDouble(),
    );
  }
}
