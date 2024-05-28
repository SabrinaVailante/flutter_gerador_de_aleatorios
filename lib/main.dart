import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/splash_scren.view.dart';

import 'home.view.dart';

void main() {
  runApp(const GeradorAleatorio());
}
class GeradorAleatorio extends StatelessWidget {
  const GeradorAleatorio({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 30, 2, 40)),
        useMaterial3: true,

      ),
      home:  SplashScreen(),
    );
  }
}



