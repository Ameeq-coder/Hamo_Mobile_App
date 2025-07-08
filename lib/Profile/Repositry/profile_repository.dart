import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> fetchProfile(String userId) async {
    final url = Uri.parse("https://hamo-backend.vercel.app/api/v1/userdetail/details/$userId");

    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ProfileModel.fromJson(jsonData['userDetails']);
    } else {
      throw Exception("Failed to load profile");
    }
  }
}
