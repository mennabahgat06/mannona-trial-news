import 'package:dio/dio.dart';

class DioFactory {
  static Dio? _dio;

  static Dio getDio() {
    _dio ??= Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return _dio!;
  }
}
