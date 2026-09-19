import 'package:dio/dio.dart';
import 'api_consumer.dart';
import 'dio_factory.dart';

class DioConsumer implements ApiConsumer {
  final Dio client = DioFactory.getDio();

  @override
  Future<dynamic> get(String path, {String? baseUrl, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(
        (baseUrl ?? '') + path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('message')) {
          throw data['message'].toString();
        }
      }
      throw e.message ?? "Connection Error";
    }
  }
}
