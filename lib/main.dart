import 'package:flutter/material.dart';
import 'package:flutter_game_app/web/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 44, 4, 4),
        ),
        useMaterial3: true,
        fontFamily: 'Witchwoode',
      ),
      home: const HomeView(),
    );
  }
}
