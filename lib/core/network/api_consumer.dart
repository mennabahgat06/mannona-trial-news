/// Contract for every HTTP client used in the app.
abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
  });
}
