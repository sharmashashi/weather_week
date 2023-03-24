abstract class HttpService {
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParameters});
}
