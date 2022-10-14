import 'package:amazon_app/pages/cart.dart';
import './checkout.dart';
import 'package:amazon_app/pages/homepage.dart';
import 'package:amazon_app/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
   int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static  List<Widget> screen = <Widget>[
    HomePage(),
    OrdersScreen(),
    CartScreen(),
    ChecOut(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:screen.elementAt(_selectedIndex),
        bottomNavigationBar: CurvedNavigationBar(
          height: 55.0,
          color: Colors.black ,
          backgroundColor: Color.fromARGB(255, 240, 238, 238),
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.list_alt_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.local_grocery_store_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outlined,
              color: Colors.white,
            ),
          ],
          onTap: _onItemTapped,
        ));
  }
}
