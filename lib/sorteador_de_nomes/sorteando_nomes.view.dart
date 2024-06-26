import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios/numeros_gerados.view.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/sorteador_de_nomes/resultado_do_sorteio.view.dart';
import 'package:lottie/lottie.dart';

class SorteandoNomesView extends StatefulWidget {
  final List<dynamic> lista;

  SorteandoNomesView({required this.lista, Key? key}) : super(key: key);

  @override
  State<SorteandoNomesView> createState() =>
      _SorteandoNomesViewState();
}

class _SorteandoNomesViewState extends State<SorteandoNomesView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NomesSorteadosView(lista: widget.lista),
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

          height: double.infinity,
          child: Lottie.asset('assets/Lotties/faces.json', fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
