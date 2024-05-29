import 'package:flutter/material.dart';
import 'package:flutter_gerador_de_numeros_aleatorios/home.view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(seconds: 15), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenView()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/game.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: const Padding(
              padding: EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Gerador de Aleatórios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Este projeto é um gerador de números aleatórios que permite ao usuário definir um intervalo específico '
                          'e a quantidade de números a serem sorteados. O objetivo principal deste projeto foi aplicar os '
                          'conhecimentos adquiridos sobre persistência de dados utilizando a biblioteca SharePreference do Flutter. '
                          'Através dessa aplicação, é possível armazenar as preferências do usuário, como o intervalo definido e a '
                          'quantidade de números, garantindo que essas informações sejam mantidas mesmo após o fechamento e reabertura do aplicativo.'
                          '\n\n FUNCIONALIDADES: \n'
                          '\n Definição do intervalo de números a serem sorteados.'
                          '\n Seleção da quantidade de números desejados.'
                          '\n Persistência das configurações do usuário com SharePreference. '
                          '\n Interface intuitiva e fácil de usar.'
                          '\n\n TECNOLOGIAS UTILIZADAS:\n'
                          '\n Flutter'
                          '\n Dart'
                          '\n SharePreference'
                          '\n\n Este projeto demonstra a aplicação prática de conceitos de persistência de dados em Flutter, garantindo uma experiência '
                          'de usuário contínua e personalizada.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
