import '/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './cart.dart';

class ChecOut extends StatefulWidget {
  const ChecOut({super.key});

  @override
  State<ChecOut> createState() => _ChecOutState();
}

class _ChecOutState extends State<ChecOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("checkout"),
        ),
        body: Consumer<Cart>(
          builder: (context, cart, child) {
            return ListView.builder(
                itemCount: cart.basketitem.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text("${cart.basketitem[i].title}"),
                      trailing: IconButton(
                          onPressed: () {
                            cart.remove(cart.basketitem[i]);
                          },
                          icon: Icon(Icons.remove)),
                    ),
                  );
                });
          },
        ));
  }
}
