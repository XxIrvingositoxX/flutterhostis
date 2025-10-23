import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_game_app/web/components/header.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/chat/chat_controller.dart';
import '../../features/chat/chat_repository.dart';
import '../../core/api_client.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});
  final String title = "Chat Bot";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(ChatRepository(ApiClient())),
      child: Scaffold(
        appBar: Header(title: title),
        drawer: const Sidebar(),
        body: const ChatScreen(),
      ),
    );
  }
}
