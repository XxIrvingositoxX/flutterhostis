// lib/core/api_client.dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  static String _resolveBaseUrl() {
    if (kIsWeb) return 'http://localhost:8000'; // navegador en tu PC
    if (Platform.isAndroid) return 'http://10.0.2.2:8000'; // Android Emulator
    // iOS Simulator en Mac normalmente acepta localhost también:
    if (Platform.isIOS) return 'http://localhost:8000';
    // fallback
    return 'http://localhost:8000';
  }

  ApiClient({String? baseUrl})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? _resolveBaseUrl(),
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.json,
        ),
      );
}
