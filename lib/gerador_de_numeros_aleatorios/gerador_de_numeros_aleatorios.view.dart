import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeradorDeNumerosAleatoriosView extends StatefulWidget {
  const GeradorDeNumerosAleatoriosView({super.key});

  @override
  State<GeradorDeNumerosAleatoriosView> createState() =>
      _GeradorDeNumerosAleatoriosViewState();
}

class _GeradorDeNumerosAleatoriosViewState
    extends State<GeradorDeNumerosAleatoriosView> {
  int? numeroGerado = 0;
  final CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  final TextEditingController minimumNumberController = TextEditingController();
  final TextEditingController maximumNumberController = TextEditingController();
  final TextEditingController numbersController = TextEditingController();
  int numbers = 0;

  bool _isOk = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO) ?? 0;
    });
  }

  void gerarNumero() async {
    final storage = await SharedPreferences.getInstance();
    var random = Random();

    int min = int.tryParse(minimumNumberController.text) ?? 0;
    int max = int.tryParse(maximumNumberController.text) ?? 100;

    if (min >= max) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('O valor mínimo deve ser menor que o valor máximo.')),
      );
      return;
    }

    setState(() {
      numeroGerado = min + random.nextInt(max - min + 1);
    });

    storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gerador de Números",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 112, 60, 240),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Background/numerosAleatorios.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(203, 0, 0, 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Range de Números",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minimumNumberController,
                          decoration: InputDecoration(
                            labelText: "Mínimo",
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: maximumNumberController,
                          decoration: InputDecoration(
                            labelText: "Máximo",
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Quantos números deseja gerar?",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: numbersController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            numbers = int.tryParse(numbersController.text) ?? 0;
                            numbers += 1;
                            numbersController.text = numbers.toString();
                          });
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            numbers = int.tryParse(numbersController.text) ?? 0;
                            if (numbers > 0) {
                              numbers -= 1;
                              numbersController.text = numbers.toString();
                            }
                          });
                        },
                        child: const Icon(Icons.remove, color: Colors.white),
                      ),
                      fillColor: Colors.white.withOpacity(0.2),
                      hintText: "0",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: const OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Permite números repetidos?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Switch(
                          value: _isOk,
                          onChanged: (value) {
                            setState(() {
                              _isOk = value;
                            });
                          })
                    ],
                  ),
                  Text("Filtrar resultados", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(decoration: InputDecoration(filled: true, fillColor: Colors.white.withOpacity(0.2), border: OutlineInputBorder()),items: const [
                    DropdownMenuItem(value: 1, child: Text("Todos")),
                    DropdownMenuItem(value: 2, child: Text("Impar")),
                    DropdownMenuItem(value: 3, child: Text("Par"))
                  ], onChanged: (value) {}),
                  Text("Organizar resultados", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(decoration: InputDecoration(filled: true, fillColor: Colors.white.withOpacity(0.2), border: OutlineInputBorder()),items: const [
                    DropdownMenuItem(value: 1, child: Text("Todos")),
                    DropdownMenuItem(value: 2, child: Text("I mpar")),
                    DropdownMenuItem(value: 3, child: Text("Par"))
                  ], onChanged: (value) {}),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Número Gerado:",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          Text(numeroGerado.toString(),
                              style: const TextStyle(
                                  fontSize: 36, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: gerarNumero,
        ),
      ),
    );
  }
}
