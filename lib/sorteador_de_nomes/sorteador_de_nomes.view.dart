import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sorteando_nomes.view.dart';

class SorteioDePessoasView extends StatefulWidget {
  const SorteioDePessoasView({super.key});

  @override
  State<SorteioDePessoasView> createState() => _SorteioDePessoasViewState();
}

class _SorteioDePessoasViewState extends State<SorteioDePessoasView> {
  final TextEditingController nomesController = TextEditingController();
  final TextEditingController numbersController =
      TextEditingController(text: '1');
  int numbers = 1;
  bool _isOk = false;
  List<String> listaNomes = [];
  bool isOrdemAlfabetica = false;
  List<String> listaSorteada = [];
  int quantidadeDeNomes = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listaNomes = prefs.getStringList('nomes') ?? [];
      isOrdemAlfabetica = prefs.getBool('isOrdemAlfabetica') ?? false;
    });
  }

  Future<void> salvarDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('nomes', listaNomes);
    prefs.setBool('isOrdemAlfabetica', isOrdemAlfabetica);
    prefs.setInt('quantidadeDeNomes', quantidadeDeNomes);
  }

  void sortearNomes() {
    listaSorteada.clear();
    final random = Random();
    for (int i = 0; i < numbers; i++) {
      int index = random.nextInt(listaNomes.length);
      listaSorteada.add(listaNomes[index]);
    }
    if (isOrdemAlfabetica) {
      listaSorteada.sort();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Sorteio de Pessoas",
            style: TextStyle(color: Colors.white),
          ),
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
                      "Quantas pessoas?",
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
                              numbers =
                                  int.tryParse(numbersController.text) ?? 1;
                              numbers += 1;
                              numbersController.text = numbers.toString();
                            });
                          },
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
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
                        fillColor: Colors.white.withOpacity(0.2),
                        hintText: "1",
                        hintStyle: const TextStyle(color: Colors.white),
                        border: const OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Adicionar Pessoas",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: nomesController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.2),
                        hintText: "Gabriel,Sabrina,Vitor,...",
                        hintStyle: const TextStyle(
                            color: Color.fromRGBO(
                                255, 255, 255, 0.3215686274509804)),
                        border: const OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 112, 60, 240)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                          minimumSize:
                              MaterialStateProperty.all(const Size(180, 60))),
                      onPressed: () {
                        setState(() {
                          List<String> novosNomes =
                              nomesController.text.split(',');
                          novosNomes = novosNomes
                              .map((nome) => nome.trim())
                              .where((nome) => nome.isNotEmpty)
                              .toList();
                          for (int i = 0; i < novosNomes.length; i++) {
                            novosNomes[i] = novosNomes[i].trim();
                          }
                          listaNomes.addAll(novosNomes);
                          quantidadeDeNomes = listaNomes.length;
                          // Limpa o campo de texto
                          nomesController.clear();
                          // Salva os dados em SharedPreferences
                          salvarDados();
                        });
                        // Imprime a lista de nomes atualizada
                        print(listaNomes);
                      },
                      child: const Text(
                        "Adicionar nome",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Permite nomes repetidos?",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Habilitar ordem alfabética?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Switch(
                            value: isOrdemAlfabetica,
                            onChanged: (value) {
                              setState(() {
                                isOrdemAlfabetica = value;
                                salvarDados(); // Salva a preferência de ordem alfabética
                              });
                            })
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${quantidadeDeNomes.toString()} Nomes na Lista',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: listaNomes.map((e) => _caixaNome(e)).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 229, 223, 235)),
                                shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(150, 60))),
                            onPressed: () {
                              setState(() {
                                listaNomes.clear();
                                salvarDados();
                              });
                            },
                            child: const Text("Limpar Lista",
                                style: TextStyle(
                                    color: Color.fromRGBO(120, 116, 126, 1.0),
                                    fontSize: 20))),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 112, 60, 240)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(150, 60))),
                            onPressed: () {
                              setState(() {
                                sortearNomes();
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SorteandoNomesView(
                                          lista: listaSorteada)));
                            },
                            child: const Text("Sortear",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _caixaNome(String nome) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 112, 60, 240),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        nome,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
