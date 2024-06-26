import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios/gerando_numeros.view.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios/services/gerador_storage_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GeradorDeNumerosAleatoriosView extends StatefulWidget {
  const GeradorDeNumerosAleatoriosView({super.key});

  @override
  State<GeradorDeNumerosAleatoriosView> createState() =>
      _GeradorDeNumerosAleatoriosViewState();
}

class _GeradorDeNumerosAleatoriosViewState
    extends State<GeradorDeNumerosAleatoriosView> {
  GeradorStorageServices storageClass = GeradorStorageServices();
  int? numeroGerado = 0;
  final CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  final TextEditingController minimumNumberController = TextEditingController();
  final TextEditingController maximumNumberController = TextEditingController();
  final TextEditingController numbersController =
      TextEditingController(text: '1');
  int numbers = 1;
  bool _isOk = false;
  List<int> listaNumeros = [];
  bool isImpar = false;
  bool isPar = false;
  bool isCrescente = false;
  bool isDecrescente = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final storage = await SharedPreferences.getInstance();
    int min = await storageClass.getNumeroMinimo();
    int max = await storageClass.getNumeroMaximo();
    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO) ??
          0; // instanciando na propria classe
      minimumNumberController.text =
          min.toString(); // instanciando na classe services
      maximumNumberController.text =
          max.toString(); // instanciando na classe services
    });
  }

  int gerarNumero() {
    var random = Random();
    int min = int.tryParse(minimumNumberController.text) ?? 0;
    int max = int.tryParse(maximumNumberController.text) ?? 100;
    if (min >= max) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('O valor mínimo deve ser menor que o valor máximo.')),
      );
      return min;
    }
    return min + random.nextInt(max - min + 1);
  }

  void gerarLista() async {
    final storage = await SharedPreferences.getInstance();
    setState(() {
      listaNumeros.clear();
      for (int i = 0; i < numbers; i++) {
        int novoNumero = gerarNumero();
        if (isImpar && novoNumero.isEven) {
          i--;
          continue;
        } else if (isPar && novoNumero.isOdd) {
          i--;
          continue;
        }
        if (_isOk || !listaNumeros.contains(novoNumero)) {
          listaNumeros.add(novoNumero);
        } else {
          i--;
        }
      }

      if (isCrescente) {
        listaNumeros.sort();
      } else if (isDecrescente) {
        listaNumeros.sort((a, b) => b.compareTo(a));
      }
    });

    storage.setInt(CHAVE_NUMERO_ALEATORIO,
        numeroGerado!); //deixei esse sem usar a classe pra eu me lembrar como que faz direto .
    storageClass.setNumeroMinimo(
        int.parse(minimumNumberController.text)); //usando a classe services
    storageClass.setNumeroMaximo(
        int.parse(maximumNumberController.text)); //usando a classe services
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("Gerador de Números",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 112, 60, 240),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(203, 0, 0, 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Intervalo de Números",
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
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  border: const OutlineInputBorder(),
                                ),
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number)),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                                controller: maximumNumberController,
                                decoration: InputDecoration(
                                    labelText: "Máximo",
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.2),
                                    border: const OutlineInputBorder()),
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number))
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Quantos números deseja gerar?",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      readOnly: true,
                      controller: numbersController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              numbers =
                                  int.tryParse(numbersController.text) ?? 1;
                              if (numbers > 1) {
                                numbers -= 1;
                                numbersController.text = numbers.toString();
                              }
                            });
                          },
                          child: const Icon(Icons.remove, color: Colors.white),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              numbers =
                                  int.tryParse(numbersController.text) ?? 1;
                              numbers += 1;
                              numbersController.text = numbers.toString();
                            });
                          },
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                        fillColor: Colors.white.withOpacity(0.2),
                        hintText: "1",
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                    const SizedBox(height: 20),
                    const Text(
                      "Opções",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                        hint: const Text(
                          "Escolha",
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: const Color.fromRGBO(73, 72, 73, 1.0),
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: const OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                              value: 1,
                              child: Text("Todos",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: 2,
                              child: Text("Par",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: 3,
                              child: Text("Ímpar",
                                  style: TextStyle(color: Colors.white))),
                        ],
                        onChanged: (value) {
                          setState(() {
                            isPar = value == 2;
                            isImpar = value == 3;
                          });
                        }),
                    const SizedBox(height: 20),
                    const Text(
                      "Organizar resultados",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                        hint: const Text(
                          "Escolha",
                          style: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: const Color.fromRGBO(73, 72, 73, 1.0),
                        icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: const OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                              value: 1,
                              child: Text("Crescente",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: 2,
                              child: Text("Decrescente",
                                  style: TextStyle(color: Colors.white))),
                          DropdownMenuItem(
                              value: 3,
                              child: Text("Sorteio",
                                  style: TextStyle(color: Colors.white))),
                        ],
                        onChanged: (value) {
                          setState(() {
                            isCrescente = value == 1;
                            isDecrescente = value == 2;
                          });
                        }),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 112, 60, 240)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            minimumSize:
                                MaterialStateProperty.all(const Size(200, 80))),
                        onPressed: () {
                          gerarLista();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GerandoNumerosView(lista: listaNumeros)));
                        },
                        child: const Text("Gerar",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
