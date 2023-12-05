import 'package:flutter/material.dart';
import 'database_helper.dart';

class Compras extends StatefulWidget {
  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _products = [];

  void initState() {
    super.initState();
    dbHelper.initDatabase();
    _loadProducts();
  }

  void _loadProducts() async {
    final products = await dbHelper.getAllPurchases();
    setState(() {
      _products = products;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compras'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(_products[index]['nome']),
                      subtitle: Text(
                          '${_products[index]['qtd']}x: R\$ ${_products[index]['preco'].toStringAsFixed(2)}'),
                      trailing: Text(_products[index]['total'].toStringAsFixed(2)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
