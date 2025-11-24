import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'dart:ui';


class DownloadView extends StatelessWidget {
  const DownloadView({super.key});

  final String title = "Descarga Hostis Aeternus";
  final String description =
      "Prepárate para adentrarte en las sombras. Descarga el juego y comienza tu aventura oscura. "
      "Explora, sobrevive y descubre los secretos que se esconden en este mundo siniestro.";

  // URL de descarga (puede ser Play Store, App Store o tu propio servidor)
  final String downloadUrl = "https://tuservidor.com/shadowofmind-download";

  Future<void> _launchDownload() async {
    final uri = Uri.parse(downloadUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el enlace de descarga';
    }
  }

  // Glassmorphism container reutilizable
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
                image: AssetImage('assets/images/home/profile.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          // Contenido dividido en dos secciones
          Column(
            children: [
              // Menú hamburguesa arriba a la izquierda
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

              // Contenido centrado
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Descarga Hostis Aeternus",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cinzelDecorative(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Prepárate para adentrarte en las sombras. Descarga el juego y comienza tu aventura oscura.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: Colors.grey[300],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton.icon(
                            onPressed: _launchDownload,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkRed,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 8,
                            ),
                            icon: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Descargar Juego",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Después del botón de descarga
                          const SizedBox(height: 40),
                          Text(
                            "Requisitos del sistema",
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
                                    Icons.computer,
                                    color: Colors.purpleAccent,
                                  ),
                                  title: Text(
                                    "Windows 10/11",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Procesador i5, 8GB RAM, GPU GTX 1050",
                                    style: GoogleFonts.roboto(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
