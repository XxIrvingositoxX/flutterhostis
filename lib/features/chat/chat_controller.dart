import 'package:flutter/material.dart';
import 'package:flutter_game_app/core/models.dart';
import 'chat_repository.dart';

enum HealthStatus { loading, ok, down }

class ChatController extends ChangeNotifier {
  ChatController(this._repo);
  final ChatRepository _repo;

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  HealthStatus _health = HealthStatus.loading;
  HealthStatus get health => _health;

  bool _isSending = false;
  bool get isSending => _isSending;

  Future<void> init() async {
    _health = HealthStatus.loading;
    notifyListeners();
    final ok = await _repo.health();
    _health = ok ? HealthStatus.ok : HealthStatus.down;

    if (ok) {
      _messages.add(
        ChatMessage(
          role: ChatRole.bot,
          text:
              'Hola, soy Rake, una más de las entidades de este juego.\n'
              'Pregunta lo que sea y veré si lo encuentro.',
        ),
      );
    } else {
      _messages.add(
        ChatMessage(
          role: ChatRole.bot,
          text: 'Opps… Parece que nos perdimos. Intenta de nuevo más tarde.',
        ),
      );
    }
    notifyListeners();
  }

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isSending) return;

    final priorHistory = List<ChatMessage>.from(_messages);

    _messages.add(ChatMessage(role: ChatRole.user, text: trimmed));
    _isSending = true;
    notifyListeners();

    try {
      final reply = await _repo.sendChat(
        message: trimmed,
        history: priorHistory,
      );
      _messages.add(
        ChatMessage(
          role: ChatRole.bot,
          text: reply.isEmpty ? 'No recibí contenido de la API.' : reply,
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          role: ChatRole.bot,
          text:
              'Ops!, Parece que rake se perdio en el abismo, intenta mas tarde.',
        ),
      );
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  void addIncoming(String text) {
    if (text.trim().isEmpty) return;
    _messages.add(ChatMessage(role: ChatRole.bot, text: text.trim()));
    notifyListeners();
  }

  void clear() {
    _messages.clear();
    notifyListeners();
  }
}
