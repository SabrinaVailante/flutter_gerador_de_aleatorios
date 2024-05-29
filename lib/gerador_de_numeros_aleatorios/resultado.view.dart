import 'package:flutter/material.dart';

class ResultadoView extends StatelessWidget {
  final List<int> lista;

  const ResultadoView({Key? key, required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(113, 60, 248, 1.0),
        title: const Text(
          "Resultado",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return bolinha(lista[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget bolinha(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(113, 60, 248, 1.0),
        ),
        child: Center(
          child: Text(
            "$index",
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
