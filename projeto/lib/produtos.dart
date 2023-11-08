import 'package:flutter/material.dart';
import 'menu.dart';
import 'carrinho.dart';

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

