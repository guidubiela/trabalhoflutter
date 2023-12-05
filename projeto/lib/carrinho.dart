import 'package:flutter/material.dart';
import 'database_helper.dart';

class SelectedProductsScreen extends StatefulWidget {
  @override
  _SelectedProductsScreenState createState() => _SelectedProductsScreenState();
}

class _SelectedProductsScreenState extends State<SelectedProductsScreen> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    super.initState();
    dbHelper.initDatabase();
    _loadProducts();
  }

  void _loadProducts() async {
    final products = await dbHelper.getAllProducts();
    setState(() {
      _products = products;
    });
  }

  double calcularTotalPreco() {
    double total = 0.00;
    for (var product in _products) {
      total += product['preco'] * product['qtd'];
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
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_products[index]['nome']),
                  subtitle: Text(
                      'R\$ ${_products[index]['preco'].toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            dbHelper.updateProduct(_products[index]['id'],
                                _products[index]['qtd']--);
                            _loadProducts();
                          },
                          icon: Icon(Icons.remove)),
                      Text('${_products[index]['qtd']}'),
                      IconButton(
                          onPressed: () {
                            dbHelper.updateProduct(_products[index]['id'],
                                _products[index]['qtd']++);
                            _loadProducts();
                          },
                          icon: Icon(Icons.add)),
                      IconButton(
                        onPressed: () {
                          dbHelper.deleteProduct(_products[index]['id']);
                          _loadProducts();
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/produtos');
              },
              child: Text('Continuar comprando')),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                var total = 0.0;
                for (var product in _products) {
                  total = product['qtd'] * product['preco'];
                  dbHelper.insertPurchases(
                      product['nome'], product['preco'], product['qtd'], total);
                }
                //Navigator.pushNamed(context, '/compraRealizada');
              },
              child: Text('Finalizar Compra'),
            ),
          ),
        ],
      ),
    );
  }
}
