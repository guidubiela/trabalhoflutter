import 'package:flutter/material.dart';

void main() {
  runApp(Padaria());
}

class Product {
  final String nome;
  final double preco;
  int quantidade;

  Product({required this.nome, required this.preco, this.quantidade = 0});
}

class Padaria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padaria App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: ProductListScreen(),
    );
  }
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

class SelectedProductsScreen extends StatelessWidget {
  final List<Product> selectedProducts;

  SelectedProductsScreen({required this.selectedProducts});

  double calcularTotalPreco() {
    double total = 0.0;
    for (var product in selectedProducts) {
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
          Expanded(
            child: ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedProducts[index].nome),
                  subtitle: Text(
                      'R\$ ${selectedProducts[index].preco.toStringAsFixed(2)}'),
                  trailing: Text(
                    'Quantidade: ${selectedProducts[index].quantidade}',
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$ ${calcularTotalPreco().toStringAsFixed(2)}',
              style: TextStyle(fontSize:18, fontWeight: FontWeight.bold),
            ),
          ),
        ], 
      ),
    );
  }
}
