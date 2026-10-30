import 'dart:convert';

import 'package:easymove/core/network/api_client.dart';
import 'package:easymove/features/login_screen/data/Models/auth_model.dart';

abstract class UserDataSource {
  Future<dynamic> putUser(
    String endPoint, {
    required Map<String, dynamic> body,
  });

  Future<void> logout(String endPoint, {required String token});
}

class UserDataSourceImpl extends UserDataSource {
  @override
  Future<dynamic> putUser(
    String endPoint, {
    required Map<String, dynamic> body,
  }) async {
    final response = await ApiClient().postMethod(endPoint, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = json.decode(response.body);
      return UserModel.fromJson(result);
    }

    throw Exception(
      'Login request failed with status code ${response.statusCode}',
    );
  }

  @override
  Future<void> logout(String endPoint, {required String token}) async {
    final response = await ApiClient().postMethod(
      endPoint,
      body: const {},
      token: token,
    );
    if (response.statusCode != 200 &&
        response.statusCode != 201 &&
        response.statusCode != 204) {
      throw Exception(
        'Logout request failed with status code ${response.statusCode}',
      );
    }
  }
}
