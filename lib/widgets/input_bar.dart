import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  const InputBar({
    super.key,
    required this.onSend,
    this.onClear,
    this.canClear = false,
  });
  final void Function(String text) onSend;
  final VoidCallback? onClear;
  final bool canClear;

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: {
        IconButton(
          tooltip: 'Limpiar chat',
          onPressed: widget.canClear ? widget.onClear : null,
          icon: const Icon(Icons.delete_outline),
        ),
        Expanded(
          child: TextField(
            controller: _ctrl,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              hintText: 'Escribe tu mensaje...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            minLines: 1,
            maxLines: 4,
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(onPressed: _submit, icon: const Icon(Icons.send)),
      }.toList(),
    );
  }
}
