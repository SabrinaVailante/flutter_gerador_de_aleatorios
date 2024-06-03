import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios/numeros_gerados.view.dart';
import 'package:lottie/lottie.dart';

class GerandoNumerosView extends StatefulWidget {
  final List<int> lista;

  GerandoNumerosView({required this.lista, Key? key}) : super(key: key);

  @override
  State<GerandoNumerosView> createState() =>
      _GerandoNumerosViewState();
}

class _GerandoNumerosViewState extends State<GerandoNumerosView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NumerosGeradosView(lista: widget.lista),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 26, 26, 1.0),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset('assets/Lotties/dados.json', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
