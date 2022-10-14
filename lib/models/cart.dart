import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  List<products> _items = [];
  double _price = 0.0;
  void add(products item) {
    _items.add(item);
    _price += item.price;
    notifyListeners();
  }
  void remove(products item) {
    _items.remove(item);
    _price -= item.price;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalprice {
    return _price;
  }

  List<products> get basketitem {
    return _items;
  }
}
