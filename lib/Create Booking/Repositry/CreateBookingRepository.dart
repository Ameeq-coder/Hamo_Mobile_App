import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/CreateBooking.dart';

class CreateBookingRepository {
  final String baseUrl = 'https://hamo-backend.vercel.app/api/v1/booking';

  Future<CreateBooking> createBooking(Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/createbooking');
    final body = json.encode(data);

    // 🔍 Print the full URL and payload
    print('📤 POST URL: $uri');
    print('📦 Payload: $body');

    final response = await http.post(
      uri,
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    print('📥 Response Status: ${response.statusCode}');
    print('📥 Response Body: ${response.body}');

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return CreateBooking.fromJson(jsonData['booking']);
    } else {
      throw Exception('Failed to create booking');
    }
  }



  Future<List<String>> getAvailableTimeSlots(String servicemanId, String date) async {
    final url = '$baseUrl/available-slots/$servicemanId/$date';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<String>.from(data['availableSlots']);
      } else {
        throw Exception('Failed to fetch available time slots');
      }
    } catch (e) {
      throw Exception('Slot fetch error: $e');
    }
  }

}
