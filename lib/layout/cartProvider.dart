import 'package:amazon_app/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cartt with ChangeNotifier {
   String id = FirebaseAuth.instance.currentUser!.uid;
 int quantity = 0;
  get _quantity => quantity;
  int doc1 = 0;
  int doc2 = 0;
  get _doc2 => doc2;
  List<int> quantities = [];
  List<double> prices = [];
  quantitiessExtract() {
    FirebaseFirestore.instance
        .collection('v')
        .doc(id)
        .collection('mycarts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        quantities.add(doc["products"]["quantity"]);
      });
      print(quantities);
      return quantities;
    });

    notifyListeners();
  }

  priceExtract() {
    FirebaseFirestore.instance
        .collection('v')
        .doc(id)
        .collection('mycarts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        double q = double.parse(doc["price"]);
        prices.add(q);
      });
      print(prices);
      return quantities;
    });

    notifyListeners();
  }

  double totalprice = 0.0;
  calculateTotalPrice() {
    var quantitttttttttttt = quantitiessExtract();
    var pricccccccccccccc = priceExtract();
    for (int i = 0; i < quantitttttttttttt.length; i++) {
      totalprice += quantitttttttttttt[i] + pricccccccccccccc[i];
      print('total price ${totalprice.toStringAsFixed(2)}');
    }
    notifyListeners();
  }
}

