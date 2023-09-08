import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(Padaria());
}

class Padaria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padaria App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/sobre': (context) => SobreScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 217, 128),
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/padoca.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Bem-vindo à Padoca do Seu Zé',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(),
                  ),
                );
              },
              child: Text(
                'Começar',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sobre');
              },
              child: Text(
                'Sobre',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class Product {
  final String nome;
  final double preco;
  int quantidade;

  Product({required this.nome, required this.preco, this.quantidade = 0});
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product(nome: "Pão", preco: 1.50),
    Product(nome: "Bolo", preco: 15.00),
    Product(nome: "Torta", preco: 20.00),
    Product(nome: "Rosca", preco: 8.50),
    Product(nome: "Brigadeiro", preco: 1.50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos da Padoca'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].nome),
            subtitle: Text('R\$ ${products[index].preco.toStringAsFixed(2)}'),
            trailing: DropdownButton<int>(
              value: products[index].quantidade,
              onChanged: (value) {
                setState(() {
                  products[index].quantidade = value!;
                });
              },
              items: List.generate(10, (index) => index)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          List<Product> selectedProducts =
              products.where((product) => product.quantidade > 0).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SelectedProductsScreen(selectedProducts: selectedProducts),
            ),
          );
        },
      ),
    );
  }
}

class SelectedProductsScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  SelectedProductsScreen({required this.selectedProducts});

  @override
  _SelectedProductsScreenState createState() =>
      _SelectedProductsScreenState();
}

class _SelectedProductsScreenState extends State<SelectedProductsScreen> {
  bool isLoading = false;
  bool compraFinalizada = false;

  double calcularTotalPreco() {
    double total = 0.0;
    for (var product in widget.selectedProducts) {
      total += product.preco * product.quantidade;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de Compras'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$ ${calcularTotalPreco().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.selectedProducts[index].nome),
                  subtitle: Text(
                      'R\$ ${widget.selectedProducts[index].preco.toStringAsFixed(2)}'),
                  trailing: Text(
                    'Quantidade: ${widget.selectedProducts[index].quantidade}',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: compraFinalizada
                ? Text(
                    'Compra Finalizada!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : isLoading
                    ? SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (isLoading) return;
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          setState(() {
                            isLoading = false;
                            compraFinalizada = true;
                          });
                        },
                        child: Text('Finalizar Compra'),
                      ),
          ),
        ],
      ),
    );
  }
}
