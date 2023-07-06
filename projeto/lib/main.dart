import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padaria App',
      theme: ThemeData(
        primarySwatch: Color.fromARGB(255, 182, 157, 87),
      ),
      home: ProductListScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;
  bool selected;

  Product({required this.name, required this.price, this.selected = false});
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product(name: "Pão", price: 1.50),
    Product(name: "Bolo", price: 15.00),
    Product(name: "Croissant", price: 2.00),
    Product(name: "Rosquinha", price: 0.50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos de Padaria'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(products[index].name),
            subtitle: Text('R\$ ${products[index].price.toStringAsFixed(2)}'),
            value: products[index].selected,
            onChanged: (value) {
              setState(() {
                products[index].selected = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          List<Product> selectedProducts =
              products.where((product) => product.selected).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedProductsScreen(
                selectedProducts: selectedProducts,
              ),
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

  double calculateTotalPrice() {
    double total = 0.0;
    for (var product in selectedProducts) {
      total += product.price;
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
                  title: Text(selectedProducts[index].name),
                  subtitle: Text(
                      'R\$ ${selectedProducts[index].price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: R\$ ${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
