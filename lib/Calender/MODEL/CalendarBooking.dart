// models/calendar_booking_model.dart
class CalendarBooking {
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
  final DateTime createdAt;

  CalendarBooking({
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
    required this.createdAt,
  });

  factory CalendarBooking.fromJson(Map<String, dynamic> json) {
    return CalendarBooking(
      id: json['id'],
      servicemanId: json['servicemanId'],
      serviceManName: json['serviceManName'],
      userId: json['userId'],
      userName: json['userName'],
      serviceType: json['serviceType'],
      serviceOptions: json['serviceOptions'] ?? {},
      location: json['location'],
      paid: json['paid'],
      status: json['status'],
      bookingDateTime: DateTime.parse(json['bookingDateTime']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
