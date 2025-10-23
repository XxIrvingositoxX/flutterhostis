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

    // Mensaje grande dinámico al iniciar (solo UI)
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

    // 1) CAPTURA el historial ANTES de agregar el mensaje actual
    final priorHistory = List<ChatMessage>.from(_messages);

    // 2) Pinta el mensaje del usuario en la UI
    _messages.add(ChatMessage(role: ChatRole.user, text: trimmed));
    _isSending = true;
    notifyListeners();

    try {
      // 3) Envía message + history(previo)
      final reply = await _repo.sendChat(
        message: trimmed,
        history: priorHistory,
      );
      _messages.add(
        ChatMessage(
          role: ChatRole.bot,
          text: reply.isEmpty
              ? 'No recibí contenido de la API.'
              : reply, // <- antes era '...'
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          role: ChatRole.bot,
          text: 'Hubo un problema al conectar con el chat. ${e.toString()}',
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
