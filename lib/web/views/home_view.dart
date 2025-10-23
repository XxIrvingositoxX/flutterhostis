// lib/web/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_game_app/web/components/header.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';
import 'package:flutter_game_app/web/components/image_carousel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final String text = 'Welcome to Shadow Of Mind';
  final String buttomText = 'Ir a la Wiki';
  final String shortDescription =
      'Adentrate en un entorno oscuro y sinistero donde conoceras los secretos que acechan en las sombras. Explora, sobrevive y descubre la verdad oculta detras de la historia de {nombre_del_personaje}.';
  final String carouselTitle = 'Explore the Darkness';
  final String carouselDescription =
      'Dive into the shadows with our curated selection of images that capture the eerie and captivating atmosphere of Shadow Of Mind. From abandoned streets to haunting interiors, each image tells a story of mystery and suspense.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Home'),
      drawer: Sidebar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                const Opacity(
                  opacity: 0.2,
                  child: Image(
                    image: AssetImage(
                      'assets/images/home/home_dark_street.jpg',
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            text,
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                          SizedBox(height: 15),
                          Text(
                            shortDescription,
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 44, 4, 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
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
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                children: <Widget>[
                  Text(
                    carouselTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0,
                    ),
                  ),
                  AutoCarouselSlider(
                    imageUrls: [
                      'assets/images/home/home_basement.jpg',
                      'assets/images/home/home_dark_street.jpg',
                      'assets/images/home/home_white_cell.jpg',
                    ],
                  ),
                  Text(
                    carouselDescription,
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  // Aca va el rating y todo eso
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
