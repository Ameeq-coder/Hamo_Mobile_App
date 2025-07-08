import 'dart:convert';
import 'package:http/http.dart' as http;
import '../MODEL/CalendarBooking.dart';

class CalendarBookingRepository {
  Future<List<CalendarBooking>> createBooking(String userId, String dateTime) async {
    final url = Uri.parse(
        'https://hamo-backend.vercel.app/api/v1/booking/created/$userId/$dateTime');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> bookingsJson = data['bookings'];
      return bookingsJson
          .map((booking) => CalendarBooking.fromJson(booking))
          .toList();
    } else {
      throw Exception('Failed to fetch bookings');
    }
  }
}
