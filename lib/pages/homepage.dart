import 'dart:convert';
import 'package:amazon_app/models/product.dart';
import 'package:amazon_app/widget/productscontainer.dart';
import 'package:flutter/material.dart';
import 'package:amazon_app/main.dart';
import 'package:amazon_app/pages/signup.dart';
import 'package:amazon_app/services/Auth_Services.dart';
import '/component/api.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<products> myproduct = [];
  final String apiUrl = 'https://fakestoreapi.com/products';
  bool isLOading = true;
  AuthClass authClass = AuthClass();

// Future<List<products>> fetchUsers() async {
//   var response = await http.get(Uri.parse(apiUrl));
//   return (json.decode(response.body))
//       .map((e) => products.fromJson(e))
//       .toList();
// }

  void fetchData() async {
    try {
      // print(api);
      http.Response response = await http.get(Uri.parse(api));
      // print(response.body);
      var data = json.decode(response.body);
      // print(response);
      // print(data);
      data.forEach((product) {
        products t = products(
          id: product['id'],
          title: product['title'].toString(),
          description: product['description'].toString(),
          price: product['price'],
          category: product['category'].toString(),
          image: product['image'].toString(),
          rating: product['rating'],
        );

        myproduct.add(t);
        print(myproduct);

        setState(() {
          // isLOading = false;
        });
      });
    } catch (e) {
      print("Error is $e");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Image.asset(
            "assets/amazon-black-icon-16.png",
            fit: BoxFit.cover,
            width: 100,
          ),
        ),
        actions: [
          Icon(
            Icons.local_activity,
            color: Colors.white,
          )
        ],
        // title: Text("hello from django"),
        // backgroundColor: Color(0xFF001133),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SearchBox(),
            ),
            SizedBox(
              height: 10,
            ),
            // SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                'Explore',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 1),
              ),
            ),
             SizedBox(
              height: 10,
            ),
            // we gonna to build List.builder
            Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
//                    physics: ,
                  itemCount: myproduct.length,

                  itemBuilder: (context, index) => Column(
                    children: myproduct.map((e) {
                      return productsContainer(
                        id: e.id,
                        // onpress: () => delete_peto(e.id.toString()),
                        title: e.title.toString(),
                        price: e.price,
                        rating1: e.rating!['rate'],
                        rating2: e.rating!['count'],
                        description: e.description.toString(),
                        image: e.image.toString(),
                        category: e.category.toString(),
                        // onpress: ,
                      );
                    }).toList(),
                  ),
                )),
            // Column(

            //   children: myproduct.map((e) {
            //     return productsContainer(
            //       id: e.id,
            //       // onpress: () => delete_peto(e.id.toString()),
            //       title: e.title.toString(),
            //       price: e.price,
            //       rating1: e.rating['rate'],
            //       rating2: e.rating['count'],
            //       description: e.description.toString(),
            //       image: e.image.toString(),
            //       category: e.category.toString(),
            //       // onpress: ,
            //     );
            //   }).toList(),

            // ),
          ],
        ),
      ),
    );
  }

  Widget SearchBox() {
    return Stack(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200,
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 60, top: 7),
            child: TextField(
              autofocus: false,
              cursorColor: Color.fromRGBO(66, 98, 94, 1),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        Positioned(
            left: 5,
            top: 4,
            child: Icon(
              Icons.search,
              size: 30,
            )),
        Positioned(
            right: 5,
            top: 4,
            child: Icon(
              Icons.camera_enhance_outlined,
              size: 30,
            ))
      ],
    );
  }
}
