/// Error thrown by [DioConsumer] with a message that is safe to show the user.
class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => message;
}
