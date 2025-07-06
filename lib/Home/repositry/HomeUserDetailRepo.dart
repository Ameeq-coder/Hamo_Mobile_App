import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/HomeUserDetail.dart';

class HomeUserDetailRepository {
  final String baseUrl = 'https://hamo-backend.vercel.app/api/v1';

  Future<HomeUserDetail> fetchUserDetails(String userId) async {
    final url = '$baseUrl/userdetail/details/$userId';
    print('Fetching user details from: $url'); // This line prints the URL

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return HomeUserDetail.fromJson(jsonData['userDetails']);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
