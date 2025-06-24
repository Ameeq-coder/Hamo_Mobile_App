import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../models/UserDetailModel.dart';

class UserDetailRepository {
  final String baseUrl = "https://hamo-backend.vercel.app/api/v1/userdetail/createdetails";

  Future<UserDetailModel> submitUserDetails({
    required String userId,
    required String name,
    required String dob,
    required String phone,
    required String address,
    required File image,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    request.fields['userId'] = userId;
    request.fields['name'] = name;
    request.fields['dob'] = dob;
    request.fields['phone'] = phone;
    request.fields['address'] = address;

    final mimeTypeData = lookupMimeType(image.path)?.split('/');
    final fileStream = http.MultipartFile.fromBytes(
      'image',
      await image.readAsBytes(),
      filename: image.path.split('/').last,
      contentType: mimeTypeData != null
          ? MediaType(mimeTypeData[0], mimeTypeData[1])
          : MediaType('image', 'jpeg'),
    );

    request.files.add(fileStream);

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final jsonData = json.decode(respStr);
      return UserDetailModel.fromJson(jsonData['userDetails']);
    } else {
      throw Exception('Failed to upload user details');
    }
  }
}
