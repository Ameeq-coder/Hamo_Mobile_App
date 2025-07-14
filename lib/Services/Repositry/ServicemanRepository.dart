// repository/all_servicemen_location_and_cat_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/ServiceManModel.dart';

class AllServicemenLocationAndCatRepository {
  Future<List<AllServicemenLocationAndCat>> fetchServicemen(String category, String location) async {
    final response = await http.get(
      Uri.parse('https://hamo-backend.vercel.app/api/v1/servicedetail/allserviceman/by-location?category=$category&location=$location'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> list = data['servicemen'];
      return list.map((json) => AllServicemenLocationAndCat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load servicemen');
    }
  }
}
