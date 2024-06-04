import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/splash_scren.view.dart';


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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(113, 60, 248, 1.0)),
        useMaterial3: true,

      ),
      home:  SplashScreen(),
    );
  }
}



