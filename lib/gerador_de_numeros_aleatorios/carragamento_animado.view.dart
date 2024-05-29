import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios/resultado.view.dart';
import 'package:lottie/lottie.dart';

class CarregamentoAnimadoView extends StatefulWidget {
  final List<int> lista;

  CarregamentoAnimadoView({required this.lista, Key? key}) : super(key: key);

  @override
  State<CarregamentoAnimadoView> createState() =>
      _CarregamentoAnimadoViewState();
}

class _CarregamentoAnimadoViewState extends State<CarregamentoAnimadoView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoView(lista: widget.lista),
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
