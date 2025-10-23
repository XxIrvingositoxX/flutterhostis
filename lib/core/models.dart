enum ChatRole { user, bot }

class ChatMessage {
  final ChatRole role;
  final String text;
  ChatMessage({required this.role, required this.text});
}
