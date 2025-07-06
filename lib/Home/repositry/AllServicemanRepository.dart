import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/allservicemanmodel.dart';

class AllServicemanRepository {
  final String baseUrl = 'https://hamo-backend.vercel.app/api/v1';

  Future<List<AllServiceman>> getServicemenByLocation(String location) async {
    final response = await http.get(
      Uri.parse('$baseUrl/servicedetail/allserviceman/by-location?location=$location'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['servicemen'];
      return list.map((json) => AllServiceman.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch servicemen');
    }
  }
}
