import 'dart:convert';

import 'package:easymove/core/network/api_client.dart';
import 'package:easymove/features/homescreen/data/models/RealestateModel.dart';

abstract class ServicesDataSource {
  Future<dynamic> getUser(String endPoint);
}

class RealestateDataSourceImpl extends ServicesDataSource {
  @override
  Future<dynamic> getUser(String endPoint) async {
    try {
      final Response = await ApiClient().getMethod(endPoint);
      if (Response.statusCode == 200) {
        var result = json.decode(Response.body);
        return UserModel.fromJson(result);
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      print("Something went wrong");
    }
  }
}
