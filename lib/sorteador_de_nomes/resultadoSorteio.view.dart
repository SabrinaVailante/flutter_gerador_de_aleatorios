import 'package:flutter/material.dart';

class ResultadoSorteioView extends StatelessWidget {
  final List<dynamic> lista;

  const ResultadoSorteioView({Key? key, required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(113, 60, 248, 1.0),
        title: const Text(
          "Resultado",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 8.0, right: 8.0),
            child: Center(
              child: Text(
                "Os números sorteados foram:",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10.0, // Espaço horizontal entre as bolinhas
              runSpacing: 10.0, // Espaço vertical entre as bolinhas
              children: lista.map((numero) => bolinha(numero)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget bolinha(int numero) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(113, 60, 248, 1.0),
      ),
      child: Center(
        child: Text(
          "$numero",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
