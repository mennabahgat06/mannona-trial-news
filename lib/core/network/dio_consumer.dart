import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'api_exception.dart';
import 'dio_factory.dart';

class DioConsumer implements ApiConsumer {
  final Dio client = DioFactory.getDio();

  @override
  Future<dynamic> get(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(
        (baseUrl ?? '') + path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException(_readError(e));
    }
  }

  String _readError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. Please try again.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection.';
    }
    return e.message ?? 'Something went wrong.';
  }
}
