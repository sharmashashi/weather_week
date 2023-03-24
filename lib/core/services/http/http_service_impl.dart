import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_week/core/services/http/http_service.dart';


class HttpServiceImpl implements HttpService {
  @override
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await http.get(
        Uri.parse(endpoint).replace(
          queryParameters: queryParameters,
        ),);
        log(queryParameters.toString());
        log(endpoint);
    return jsonDecode(response.body);
  }
}
