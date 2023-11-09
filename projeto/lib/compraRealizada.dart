import 'package:flutter/material.dart';
import 'main.dart';


class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  bool isPurchasing = false;

  @override
  void initState() {
    super.initState();
    simulatePurchase();
  }

  void simulatePurchase() {
    Future.delayed(Duration(seconds: 0), () {

      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isPurchasing = false;
        });
      });

      setState(() {
        isPurchasing = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizando Compra'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isPurchasing
                ? CircularProgressIndicator()
                : Text('Compra Finalizada!',style: TextStyle(fontSize: 24)),
                if (isPurchasing == false)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/produtos');
                      },
                      child: Text('Pronto')
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
