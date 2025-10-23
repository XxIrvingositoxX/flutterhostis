import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/message_bubble.dart';
import '../../widgets/input_bar.dart';
import '../../widgets/typing_indicator.dart';
import '../chat/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // Dispara el health-check al entrar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().init();
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatController>();
    final messages = chat.messages;

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Banner grande de estado
    // final isOk = chat.health == HealthStatus.ok;
    // final isLoading = chat.health == HealthStatus.loading;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          // color: isLoading
          //     ? Theme.of(context).colorScheme.surface
          //     : (isOk
          //           ? Theme.of(context).colorScheme.secondaryContainer
          //           : Theme.of(context).colorScheme.errorContainer),
          // child: Text(
          //   isLoading
          //       ? 'Comprobando estado del servidor…'
          //       : (isOk
          //             ? 'Holaaaa, soy Rake, una más de las entidades de este juego. '
          //                   'Pregunta lo que sea y veré si lo encuentro.'
          //             : 'Opps… Parece que nos perdimos. ¿Intentamos de nuevo más tarde?'),
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w600,
          //     color: isLoading
          //         ? Theme.of(context).colorScheme.onSurface
          //         : (isOk
          //               ? Theme.of(context).colorScheme.onSecondaryContainer
          //               : Theme.of(context).colorScheme.onErrorContainer),
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollCtrl,
            padding: const EdgeInsets.all(12),
            itemCount: messages.length + (chat.isSending ? 1 : 0),
            itemBuilder: (context, i) {
              if (chat.isSending && i == messages.length) {
                // indicador de “typing” al final (opcional)
                return const Align(
                  alignment: Alignment.centerLeft,
                  child: TypingIndicator(),
                );
              }
              return MessageBubble(message: messages[i]);
            },
          ),
        ),
        const Divider(height: 1),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: InputBar(
              onSend: (text) {
                chat.send(text);
                _scrollToBottom();
              },
              onClear: chat.clear,
              canClear: messages.isNotEmpty,
            ),
          ),
        ),
      ],
    );
  }
}
