import 'package:flutter/material.dart';
import 'package:flutter_game_app/web/views/home_view.dart';
import 'package:flutter_game_app/web/views/wikipedia_view.dart';
import 'package:flutter_game_app/web/views/secret_codes_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow Of Mind Wiki',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 44, 4, 4),
        ),
        useMaterial3: true,
        fontFamily: 'Witchwoode',
      ),
      routes: {
        '/wiki': (context) =>WikipediaView(),
        '/secret_codes': (context) =>SecretCodesView()
      },
      home: HomeView(),
    );
  }
}
