import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/pages/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  // final Function onpress;
  final String category;
  final num rating1;
  final num rating2;
  final String image;
  final num price;

  ProductDetailsScreen({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.rating1,
    required this.rating2,
    required this.image,
    required this.price,
  });
  
// void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Container(
                // height: 450,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Image.network(image),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: rating1.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              onRatingUpdate: (rating1) {
                                print(rating1);
                              },
                            ),
                            Text(
                              " ($rating2)",
                              style: TextStyle(
                                color: Colors.amber,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "\$ $price",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          description,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(child: Icon(Icons.keyboard_arrow_down))
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Text(
                        "Reviews",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            "assets/person2.jpg",
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fatma Esmail",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 350,
                          child: Text(
                            "Good Jacket Quailty materials , i bought a brother , he us satisfaed",
                            style: TextStyle(overflow: TextOverflow.clip),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // BottomNavigationBar(items: [
              //   BottomNavigationBarItem(icon: Icon(Icons.arrow_back),label: "arr"),
              //   // BottomNavigationBarItem(icon: IconButton(icon:Text("Add TO cart") ,onPressed: (){},)),
              //   BottomNavigationBarItem(icon: Icon(Icons.arrow_back),label: 'hhh'),
              // ])
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(child: Consumer<Cart>(
        builder: (context, Cart, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigatorScreen(),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Cart.add(products(id: id, title: title, category: category, description: description, price: price, image: image,));
                  },
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.list_alt),
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
