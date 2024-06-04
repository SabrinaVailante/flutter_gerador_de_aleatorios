import 'package:flutter/material.dart';

class NomesSorteadosView extends StatelessWidget {
  final List<dynamic> lista;

  const NomesSorteadosView({Key? key, required this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool AsAList = false;
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
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                const Text("Nomes Sorteados:",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 20),
                Wrap(

                  //spacing: 5.0, // Espaço horizontal entre as bolinhas
                  //runSpacing: 1, // Espaço vertical entre as bolinhas
                  children: lista.map((nome) => tarjaNome(nome)).toList(),
                )
              ],
            ))));
  }

  Widget tarjaNome(String nome) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(113, 60, 248, 1.0),
      ),
      child: Text(
        " $nome ",
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}
