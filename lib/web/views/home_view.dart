// lib/web/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_game_app/web/components/header.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import 'package:flutter_game_app/web/components/image_carousel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String text = 'Welcome to Shadow Of Mind';
  final String buttomText = 'Ir a la Wiki';
  final String shortDescription =
      'Adéntrate en un entorno oscuro y siniestro donde conocerás los secretos que acechan en las sombras. '
      'Explora, sobrevive y descubre la verdad oculta detrás de la historia de {nombre_del_personaje}.';
  final String carouselTitle = 'Explore the Darkness';
  final String carouselDescription =
      'Dive into the shadows with our curated selection of images that capture the eerie and captivating atmosphere of Shadow Of Mind. '
      'From abandoned streets to haunting interiors, each image tells a story of mystery and suspense.';

  @override
  void initState() {
    super.initState();
    // Precargar imágenes para evitar tirones al mostrarlas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
        const AssetImage('assets/images/home/home_dark_street.jpg'),
        context,
      );
      precacheImage(
        const AssetImage('assets/images/home/home_white_cell.jpg'),
        context,
      );
      precacheImage(
        const AssetImage('assets/images/home/home_basement.jpg'),
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const darkRed = Color.fromARGB(255, 44, 4, 4);

    return Scaffold(
      appBar: const Header(title: 'Home'),
      drawer: const Sidebar(),
      body: DecoratedBox(
        // Fondo optimizado (sin Opacity sobre Image)
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home/home_dark_street.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Hero centrado
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 32,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      shortDescription,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: navegar a la Wiki
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkRed,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        buttomText,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Carrusel + descripción
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  spacing: 20,
                  children: <Widget>[
                    Text(
                      carouselTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // TIP: si controlas AutoCarouselSlider, dentro usa Image.asset(..., cacheWidth: (ancho*dpr).round())
                    const AutoCarouselSlider(
                      imageUrls: [
                        'assets/images/home/home_basement.jpg',
                        'assets/images/home/home_dark_street.jpg',
                        'assets/images/home/home_white_cell.jpg',
                      ],
                    ),
                    Text(
                      carouselDescription,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Sección extra (rating, etc.)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: const <Widget>[
                    // Aca va el rating y todo eso
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
