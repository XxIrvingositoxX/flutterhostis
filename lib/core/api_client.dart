import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({String baseUrl = 'http://localhost:8000'})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json', // <- importante en algunos backends
          },
          responseType: ResponseType.json,
        ),
      );
}
