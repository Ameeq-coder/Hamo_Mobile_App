import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/ServiceManDetailModel.dart';

class ServiceDetailRepository {
  Future<ServiceDetail> fetchServiceDetail(String serviceManId) async {
    final url = Uri.parse(
        'https://hamo-backend.vercel.app/api/v1/servicedetail/getsepecificserviceman/$serviceManId');

    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ServiceDetail.fromJson(jsonData['detail']);
    } else {
      throw Exception('Failed to load service detail');
    }
  }
}
