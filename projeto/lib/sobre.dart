import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 247, 217, 128),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Este é o aplicativo da Padoca do Seu Zé (na esquina). Desenvolvido por Guilherme Dubiela.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, 
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}