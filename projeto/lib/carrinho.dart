import 'menu.dart';
import 'produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                        color: Colors.amber,
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
