import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AutoCarouselSlider extends StatelessWidget {
  const AutoCarouselSlider({
    super.key,
    required this.imageUrls,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.9,
    this.borderRadius = 14,
    this.autoPlay = true,
  });

  final List<String> imageUrls;
  final double aspectRatio;
  final double viewportFraction;
  final double borderRadius;
  final bool autoPlay;

  bool _isNetwork(String src) =>
      src.startsWith('http://') || src.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index, realIndex) {
        final src = imageUrls[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final dpr = MediaQuery.of(context).devicePixelRatio;
                // ancho real del slide en px físicos (aprox.)
                final targetWidth = (constraints.maxWidth * dpr)
                    .clamp(400, 2000)
                    .round();

                Widget img;
                if (_isNetwork(src)) {
                  img = Image.network(
                    src,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: Colors.black26,
                      child: Center(child: Icon(Icons.broken_image)),
                    ),
                  );
                } else {
                  img = Image.asset(
                    src,
                    fit: BoxFit.cover,
                    cacheWidth:
                        targetWidth, // clave para rendimiento con assets
                    filterQuality: FilterQuality.none,
                  );
                }

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    img,
                    // Overlay muy sutil (opcional)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.08),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: autoPlay,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        viewportFraction: viewportFraction,
        aspectRatio: aspectRatio,
        // Nota: si usas `aspectRatio`, NO pongas `height`, el paquete ignora uno de los dos.
      ),
    );
  }
}
