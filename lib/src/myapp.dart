import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;

import 'view/home.dart';

class MyApp extends StatefulWidget {
  const MyApp(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      navigatorObservers: [
        asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(title: 'Criação das etiquetas'),
      },
    );
  }
}
