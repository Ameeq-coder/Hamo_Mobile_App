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

}
