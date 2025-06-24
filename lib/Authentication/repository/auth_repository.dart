import 'dart:convert';
import 'package:hamo/Authentication/models/Login_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRepository {
  final String _baseUrl = 'https://hamo-backend.vercel.app/api/v1/auth/signup';

  Future<UserModel> signup(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl.trim()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data['user']);

        // ✅ Save ID in Hive
        final box = Hive.box('userBox');
        await box.put('userId', user.id);
        print('Saved user ID to Hive: ${user.id}');

        return user;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Signup failed: ${response.body}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('https://hamo-backend.vercel.app/api/v1/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }


}