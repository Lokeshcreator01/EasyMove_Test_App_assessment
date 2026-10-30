import 'package:easymove/core/constants/api_Constsnts.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  static final http.Client ioClient = http.Client();

  Future<http.Response> getMethod(String endPoint) async {
    final realestateUrl = "${ApiConstsnts.Base_URL}$endPoint";
    final response = await ioClient.get(Uri.parse(realestateUrl));
    return response;
  }

  Future<http.Response> postMethod(
    String endPoint, {
    required Map<String, dynamic> body,
    String? token,
  }) async {
    final authUrl = "${ApiConstsnts.Base_URL}$endPoint";
    return ioClient.post(
      Uri.parse(authUrl),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}
