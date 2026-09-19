abstract class ApiConsumer {
  Future<dynamic> get(String path, {String? baseUrl, Map<String, dynamic>? queryParameters});
}
