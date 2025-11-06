import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_game_app/web/components/header.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import 'package:flutter_game_app/features/providers/providers.dart';

class SecretCodesView extends ConsumerStatefulWidget {
  const SecretCodesView({super.key});

  @override
  ConsumerState<SecretCodesView> createState() => _SecretCodesViewState();
}

class _SecretCodesViewState extends ConsumerState<SecretCodesView> {
  final _formKey = GlobalKey<FormState>();
  final _codeCtrl = TextEditingController();

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _redeem() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final code = _codeCtrl.text.trim();

    // 1) Notificación local
    final notifier = ref.read(notificationServiceProvider);
    await notifier.showLocal(
      title: '¡Secreto desbloqueado!',
      body:
          'Usaste el código $code. Nuevas pistas se han revelado: explora la Wikipedia y descubre más.',
      payload: 'secret_code:$code',
    );

    // 2) Incrementar badge
    ref.read(badgeCountProvider.notifier).update((count) => count + 1);

    // 3) UX: limpiar input, quitar foco y feedback
    _codeCtrl.clear();
    FocusScope.of(context).unfocus();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Código canjeado. ¡Revisa la notificación!'),
        ),
      );
    }
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    const darkRed = Color.fromARGB(255, 44, 4, 4);
    final badge = ref.watch(badgeCountProvider);

    return Scaffold(
      appBar: Header(
        title: 'Canjear Código',
        notificationCount: badge, // muestra el badge en el AppBar
        onNotificationsTap: () {
          // Navega a tu lista de notificaciones si aplica
        },
      ),
      drawer: const Sidebar(),
      body: DecoratedBox(
        // Fondo con imagen + colorFilter (mejor rendimiento que Opacity+Image)
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home/home_white_cell.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Encontraste el código secreto?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ingresa el código numérico de 8 dígitos para desbloquear contenido oculto. '
                      '¡Descifra, explora y revela lo que se esconde entre las sombras!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 28),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _codeCtrl,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(8),
                            ],
                            onFieldSubmitted: (_) => _redeem(),
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Código de 8 dígitos',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.35),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white24,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white70,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              final v = value?.trim() ?? '';
                              if (v.isEmpty) return 'Ingresa tu código';
                              if (v.length != 8) {
                                return 'El código debe tener 8 dígitos';
                              }
                              if (!RegExp(r'^\d{8}$').hasMatch(v)) {
                                return 'Solo números (0-9)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 22),
                          ElevatedButton(
                            onPressed: _redeem,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkRed,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 6,
                            ),
                            child: const Text(
                              'Canjear código',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
