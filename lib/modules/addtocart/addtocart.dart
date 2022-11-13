import 'package:amazon_app/layout/home_provider.dart';
import 'package:amazon_app/models/cart_model.dart';
import 'package:amazon_app/models/products_model.dart';
import 'package:amazon_app/modules/product_details/detials.dart';
import 'package:amazon_app/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import '../../adaptive/components_adaptive.dart';
import '../../shared/components/components.dart';
import 'package:rxdart/rxdart.dart';

// class AddToCart extends StatefulWidget {
//   @override
//   State<AddToCart> createState() => _AddToCartState();
// }

// class _AddToCartState extends State<AddToCart> {
//   String id = FirebaseAuth.instance.currentUser!.uid;

//   var carts;

class GetCart extends StatelessWidget {
  String id = FirebaseAuth.instance.currentUser!.uid;
  late ProductsModel productsModel;

  get collectionStream => null;
  double totleprice = 0.0;
  int countofelement = 0;

  @override
  Widget build(BuildContext context) {
    final providerdate =
        Provider.of<HomeProvider>(context).getproductsAddedToFireStore;
   

    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        body: Consumer<HomeProvider>(builder: (context, homeprovider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 430,
                  child: StreamBuilder(
                      stream: homeprovider.getproductsAddedToFireStore(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        } else {
                          print('bbbbbbbbbbbbbbbbbb');

                          print("snapshot:: data >>>> ${snapshot.data!.docs}");
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var doc = snapshot.data!.docs[index];

                              var data = doc.data() as Map;
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                var doc = snapshot.data!.docs[i];

                                var data = doc.data() as Map;
                                countofelement +=
                                    data['products']['quantity'] as int;
                                print(countofelement);

                                var quantityElemnt =
                                    data['products']['quantity'] as int;
                                double PriceElemnt =
                                    double.parse(data['price']);
                                totleprice += (quantityElemnt * PriceElemnt);
                                var totleprice1 = totleprice;
                                print(totleprice);

                                print(totleprice);
                              }
                              return Card(
                                color: HexColor('2f2f2f'),
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: HexColor('ebebeb'),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                data['image'].toString()),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            RichText(
                                              //  overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '${data['category'].toString()}\n',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            RichText(
                                              //  overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '${data['title'].toString()}\n',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            RichText(
                                              maxLines: 1,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: HexColor('ff9900'),
                                                      fontSize: 16.0),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '\$${data['price']}\n',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white12,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: RichText(
                                                maxLines: 1,
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color:
                                                            HexColor('ff9900'),
                                                        fontSize: 14.0),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'x${data['products']['quantity'].toString()}\n',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15.0,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              print(snapshot
                                                  .data!.docs[index].id);
                                              final collection =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('v')
                                                      .doc(id)
                                                      .collection('mycarts')
                                                      .doc(snapshot
                                                          .data!.docs[index].id)
                                                      .get();

                                              final batch = FirebaseFirestore
                                                  .instance
                                                  .batch();
                                              batch.delete(doc.reference);

                                              return batch.commit();
                                           
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: HexColor('ff9900'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            
                            },
                          );

                        }
                      }),
                ),

                
                Container(
                  height: 50,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('v')
                          .doc(id)
                          .collection('mycarts')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        } else {
                          print("snapshot:: data >>>> ${snapshot.data!.docs}");
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            var doc = snapshot.data!.docs[i];

                            var data = doc.data() as Map;
                            countofelement +=
                                data['products']['quantity'] as int;
                            print(countofelement);

                            var quantityElemnt =
                                data['products']['quantity'] as int;
                            double PriceElemnt = double.parse(data['price']);
                            totleprice += (quantityElemnt * PriceElemnt);
                            var totleprice1 = totleprice.toStringAsPrecision(2);
                            print(totleprice);

                            print(totleprice);
                          }
                          return Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$countofelement Items',
                                    style: TextStyle(
                                      color: HexColor('ff9900'),
                                    ),
                                  ),
                                  Text(
                                    '\$${totleprice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: HexColor('ff9900'),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('ff9900'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Text(
                      'CheckOut',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  


  }
}


 
