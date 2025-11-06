import 'package:dio/dio.dart';
import '../../core/api_client.dart';
import 'package:flutter_game_app/core/models.dart';

class ChatRepository {
  final ApiClient api;
  ChatRepository(this.api);

  Future<bool> health() async {
    try {
      final res = await api.dio.get('/health');
      // print('HEALTH: ${res.statusCode} ${res.data}');
      if (res.statusCode == 200 && res.data is Map) {
        final status = (res.data['status'] ?? '').toString().toLowerCase();
        return status == 'ok';
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<String> sendChat({
    required String message,
    required List<ChatMessage> history,
  }) async {
    final body = {
      'message': message,
      'history': history.map((m) {
        final role = (m.role == ChatRole.user) ? 'user' : 'assistant';
        return {'role': role, 'content': m.text};
      }).toList(),
    };

    final Response res = await api.dio.post('/chat', data: body);

    final data = res.data;
    return _extractReply(data).trim();
  }

  String _extractReply(dynamic data) {
    if (data == null) return '';

    if (data is String) return data;

    if (data is List) {
      for (final item in data) {
        final s = _extractReply(item);
        if (s.isNotEmpty) return s;
      }
      return '';
    }

    if (data is Map) {
      for (final key in ['message', 'content', 'reply', 'text', 'answer']) {
        final v = data[key];
        if (v is String && v.trim().isNotEmpty) return v;
      }

      if (data['data'] != null) {
        final nested = _extractReply(data['data']);
        if (nested.isNotEmpty) return nested;
      }

      final choices = data['choices'];
      if (choices is List && choices.isNotEmpty) {
        final c0 = choices.first;
        if (c0 is Map) {
          final msg = c0['message'];
          if (msg is Map && msg['content'] is String) {
            return (msg['content'] as String);
          }
          if (c0['text'] is String) return c0['text'];
        }
      }

      for (final v in data.values) {
        final s = _extractReply(v);
        if (s.isNotEmpty) return s;
      }
    }

    return '';
  }
}
