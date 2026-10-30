import 'dart:convert';

import 'package:easymove/core/network/api_client.dart';
import 'package:easymove/features/Services_screen/data/model/Services_model.dart';

abstract class ServicesDataSource {
  Future<dynamic> getUser(String endPoint);
}

class ServicesDataSourceImpl extends ServicesDataSource {
  @override
  Future<dynamic> getUser(String endPoint) async {
    try {
      final response = await ApiClient().getMethod(endPoint);
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return Servicesdata_model.fromJson(result);
      } else {
        throw Exception(
          'Services request failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Unable to load services: $e');
    }
  }
}
