import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import 'package:flutter_game_app/web/components/image_carousel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final String title = 'HOSTIS AETERNUS';
  final String description =
      'Adéntrate en un entorno oscuro y siniestro donde descubrirás los secretos que acechan en las sombras. Explora, sobrevive y descubre la verdad oculta detrás de la historia de Jack.';

  final String carouselTitle = 'Explora la Oscuridad';
  final String carouselDescription =
      '“Sumérgete en las sombras con nuestra selección curada de imágenes que capturan la atmósfera inquietante y cautivadora de Hostis Aeternus. Desde paisajes desolados hasta encuentros espeluznantes, cada imagen te invita a descubrir los misterios que aguardan en cada rincón oscuro del juego.”';

  final List<String> imageUrls = [
    'assets/images/home/group.jpg',
    'assets/images/home/group2.jpg',
    'assets/images/home/group3.jpg',
    'assets/images/home/boyred.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      body: Stack(
        children: [
          // Fondo oscuro con imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home/boy.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          // Contenido scrollable
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Ícono de menú hamburguesa manual
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

                  // Título principal
                  Text(
                    title,
                    style: GoogleFonts.cinzelDecorative(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Descripción
                  Text(
                    description,
                    style: GoogleFonts.roboto(
                      color: Colors.grey[300],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Botón púrpura
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/wiki');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 44, 4, 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      'Go to Wiki',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  
                  // Sección: Explore the Darkness
                  Text(
                    carouselTitle,
                    style: GoogleFonts.cinzel(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _glassContainer(
                    child: Column(
                      children: [
                        const AutoCarouselSlider(
                          imageUrls: [
                            'assets/images/home/group.jpg',
                            'assets/images/home/group2.jpg',
                            'assets/images/home/group3.jpg',
                            'assets/images/home/boyred.jpg',
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            carouselDescription,
                            style: GoogleFonts.roboto(
                              color: Colors.grey[300],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/secret_codes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 44, 4, 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Canjear código',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Noticias/Eventos
                  Text(
                    "Últimas Noticias",
                    style: GoogleFonts.cinzel(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _glassContainer(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.newspaper,
                            color: Colors.purpleAccent,
                          ),
                          title: Text(
                            "Evento especial de Halloween",
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Explora nuevas misiones y códigos ocultos.",
                            style: GoogleFonts.roboto(color: Colors.grey[300]),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.update,
                            color: Colors.purpleAccent,
                          ),
                          title: Text(
                            "Nueva actualización 1.2",
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Corrección de bugs y mejoras visuales.",
                            style: GoogleFonts.roboto(color: Colors.grey[300]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Sección: Features
                  Text(
                    'Características',
                    style: GoogleFonts.cinzel(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _featureCard(Icons.star, 'Puntuación', '4.8/5'),
                      _featureCard(
                        Icons.people,
                        'Jugadores',
                        'Modo de un solo jugador',
                      ),
                      _featureCard(Icons.lock, 'Secretos', 'Lore oculto'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Glassmorphism container
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

  // Tarjetas de características
  Widget _featureCard(IconData icon, String title, String subtitle) {
    return _glassContainer(
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: Color.fromARGB(255, 44, 4, 4), size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.cinzel(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.roboto(color: Colors.grey[300], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
