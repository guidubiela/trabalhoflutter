import 'package:flutter/material.dart';

void main() => runApp(ExemploInicial());

class ExemploInicial extends StatefulWidget {
  ExemploInicial({Key? key}) : super(key: key);
  @override
  _ExemploInicial createState() => _ExemploInicial();
}

class _ExemploInicial extends State {
  var _currentPage = 0;
  var _pages = {
    Text("Página 1 - ínicio"),
    Text("Página 2 - Carrinho"),
    Text("Página 3 - Pagamento")
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _pages.elementAt(_currentPage)
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Início"
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.shopping_basket), label: "Carrinho"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money), label: "Pagamento" 
            )
          ],
          currentIndex: _currentPage,
          fixedColor: Color.fromARGB(255, 69, 130, 243),
          onTap: (int inIndex) {
            setState(() {
              _currentPage = inIndex;
            });
          },
        ),
      ),
    );
  }
}
