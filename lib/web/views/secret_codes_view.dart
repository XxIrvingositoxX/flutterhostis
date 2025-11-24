import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

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

    return Scaffold(
      drawer: const Sidebar(),
      body: Stack(
        children: [
          // Fondo con imagen oscura
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home/group2.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          // Contenido scrollable
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Column(
                children: [
                  // Menú hamburguesa manual
                  Align(
                    alignment: Alignment.topLeft,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Título
                  Text(
                    '¿Encontraste el código secreto?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzelDecorative(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Descripción
                  Text(
                    'Ingresa el código numérico de 8 dígitos para desbloquear contenido oculto. '
                    '¡Descifra, explora y revela lo que se esconde entre las sombras!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.grey[300],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Formulario
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
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Código de 8 dígitos',
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.white54,
                            ),
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
                            if (v.length != 8)
                              return 'El código debe tener 8 dígitos';
                            if (!RegExp(r'^\d{8}$').hasMatch(v))
                              return 'Solo números (0-9)';
                            return null;
                          },
                        ),
                        const SizedBox(height: 22),

                        // Botón
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
                          child: Text(
                            'Canjear código',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Después del botón "Canjear código"
                        const SizedBox(height: 40),
                        Text(
                          "Historial de códigos desbloqueados",
                          style: GoogleFonts.cinzel(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _glassContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.lock_open,
                                  color: Colors.greenAccent,
                                ),
                                title: Text(
                                  "Código 12345678",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  "Lore desbloqueado: El sótano oscuro",
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.lock_open,
                                  color: Colors.greenAccent,
                                ),
                                title: Text(
                                  "Código 87654321",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  "Lore desbloqueado: La celda blanca",
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: child,
        ),
      ),
    );
  }
}
