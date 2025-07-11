// all_booking_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/AllBookingmodel.dart';

class AllBookingRepository {
  Future<List<AllBooking>> fetchAllBookings(String userId) async {
    final url = Uri.parse(
        'https://hamo-backend.vercel.app/api/v1/booking/allbookings/user/$userId');

    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List bookingsJson = json.decode(response.body)['bookings'];
      return bookingsJson.map((json) => AllBooking.fromJson(json)).toList();
    } else if(response.statusCode==404){
      print('No Booking Found For This User');
      return []; // return empty list instead of throwing
    }else{
      throw Exception('Failed to load bookings');
    }
  }

  Future<String> completeBooking(String bookingId) async {
    final url = Uri.parse(
        'https://hamo-backend.vercel.app/api/v1/booking/specificbooking/$bookingId/complete');

    final response = await http.put(url); // PUT method

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to complete booking');
    }
  }

  Future<String> cancelbooking(String bookingId) async {
    final url = Uri.parse(
        'https://hamo-backend.vercel.app/api/v1/booking/specificbooking/$bookingId/cancel');

    final response = await http.put(url); // PUT method

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to complete booking');
    }
  }

}
