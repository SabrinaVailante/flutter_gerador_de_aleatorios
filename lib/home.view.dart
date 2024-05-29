import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios/gerador_de_numeros_aleatorios.view.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/sorteador_de_nomes/sorteador_de_nomes.view.dart';
import 'package:lottie/lottie.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: DrawerButton(onPressed: () {}),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/background/game.jpg',
              ),
              fit: BoxFit.cover,
            )),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                    height: 350,
                    width: 350,
                    child: Lottie.asset('assets/Lotties/dados.json',
                        fit: BoxFit.cover)),
                const Text(
                    "O que vamos"
                    "\n sortear?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                PagesButtons(
                    'Números', GeradorDeNumerosAleatoriosView()),
                PagesButtons(
                    'Pessoas', SorteioDePessoasView()),
                PagesButtons(
                    'Onde ir?', GeradorDeNumerosAleatoriosView()),

              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget PagesButtons(String text, page) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(113, 60, 248, 1.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            minimumSize: MaterialStateProperty.all(const Size(300, 50))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
