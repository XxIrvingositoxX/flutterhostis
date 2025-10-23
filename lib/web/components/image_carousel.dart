import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AutoCarouselSlider extends StatelessWidget {
  final List<String> imageUrls;

  const AutoCarouselSlider({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Image.network(imageUrls[itemIndex], fit: BoxFit.cover),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        height: 200,
      ),
    );
  }
}
