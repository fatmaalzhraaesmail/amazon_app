// import 'dart:convert';

// import 'package:amazon_app/component/api.dart';
// import 'package:amazon_app/models/product.dart';
// import 'package:amazon_app/widget/productscontainer.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class productlist extends StatefulWidget {
//   const productlist({super.key});

//   @override
//   State<productlist> createState() => _productlistState();
// }

// class _productlistState extends State<productlist> {
//   List<products> myproduct = [];
//   final String apiUrl = 'https://fakestoreapi.com/products';
//   bool isLOading = true;
//   void fetchData() async {
//     try {
//       // print('hello');
//       // print('$apiUrl');
//       http.Response response = await http.get(Uri.parse(apiUrl));
//       print(response.body);
//       var data = json.decode(response.body.toString());
//       print(response);
//       // print(data);
//       // print(data);
//       data.forEach((product) {
//         products t = products(
//           id: product['id'].toString(),
//           title: product['title'].toString(),
//           description: product['description'].toString(),
//           price: product['price'],
//           category: product['category'].toString(),
//           image: product['image'].toString(),
//           rating: product['rating'],
//         );

//         myproduct.add(t);
//         // print("jjjjj$myproduct");

//         // setState(() {
//         //   isLOading = false;
//         // });
//       });
//     } catch (e) {
//       print("Error is $e");
//     }
//   }

//   @override
//   void initState() {
//     fetchData();
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("hello from django"),
//         backgroundColor: Color(0xFF001133),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: myproduct.map((e) {
//             return productsContainer(
//               id: e.id,
//               // onpress: () => delete_peto(e.id.toString()),
//               title: e.title,
//               price: e.price.toString(),
//               rating: e.rating,
//               description: e.description.toString(),
//               image: e.image.toString(),
//               category: e.category.toString(),
//               // onpress: ,
//             );

//             print('fffff');
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
