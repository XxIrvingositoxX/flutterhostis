import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/chat/chat_controller.dart';
import '../../features/chat/chat_repository.dart';
import '../../core/api_client.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});
  final String title = "Habla con Rake";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(ChatRepository(ApiClient())),
      child: Scaffold(
        drawer: const Sidebar(),
        body: Stack(
          children: [
            // Contenido principal
            Column(
              children: [
                // Menú hamburguesa manual
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Título
                Text(
                  title,
                  style: GoogleFonts.cinzelDecorative(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // ChatScreen con glassmorphism
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const ChatScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}