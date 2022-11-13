import 'package:amazon_app/layout/home_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class orderScreen extends StatefulWidget {
  const orderScreen({super.key});

  @override
  State<orderScreen> createState() => _orderScreenState();
}

class _orderScreenState extends State<orderScreen> {
  String id = FirebaseAuth.instance.currentUser!.uid;
    double totleprice = 0.0;
  int countofelement = 0;
  @override
  Widget build(BuildContext context) {
    final cartData =
        Provider.of<HomeProvider>(context).getproductsAddedToFireStore;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: HexColor('2f2f2f'),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Credit Card',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '3541 5575042 33006',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ashik Mia',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                            width: 60,
                            height: 60,
                            child: Image.asset('assets/images/mastercard.png'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                } else {
                  var doc = snapshot.data!;

                  var data = doc.data();
                  print("snapshot:: data >>>> ${snapshot.data!.data()}");

                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: HexColor('2f2f2f'),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data!['name']['firstname']} ${data['name']['lastname']}',
                                  // '\$${totleprice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${data['address']['city']} ${data['address']['street']}',
                                  // '\$${totleprice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${data['address']['number']}',
                                  // '\$${totleprice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Change Address',
                                            style: TextStyle(
                                              color: HexColor('ff9900'),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('MyOrder'),
                          ],
                        ),
                         SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: StreamBuilder(
                              stream: cartData(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return new Text("Loading");
                                } else {
                                  print(
                                      "snapshot:: data >>>> ${snapshot.data!.docs}");
                                  return SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.27,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, index) {
                                        var doc = snapshot.data!.docs[index];

                                        var data = doc.data() as Map;
                                        return Card(
                                          color: HexColor('2f2f2f'),
                                          elevation: 5.0,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 120,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: HexColor(
                                                                'ebebeb'),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  data['image']
                                                                      .toString()),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width: 150,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          RichText(
                                                            //  overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16.0),
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '${data['category'].toString()}\n',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ]),
                                                          ),
                                                        SizedBox(height: 10,),
                                                          RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16.0),
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '${data['title'].toString()}\n',
                                                                      style: const TextStyle(
                                                                          // overflow: TextOverflow.ellipsis,
                                                                          fontWeight: FontWeight.bold)),
                                                                ]),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          RichText(
                                                            maxLines: 1,
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        'ff9900'),
                                                                    fontSize:
                                                                        16.0),
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          'x${data['products']['quantity'].toString()}\n',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ]),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          RichText(
                                                            maxLines: 1,
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        'ff9900'),
                                                                    fontSize:
                                                                        16.0),
                                                                children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '${data['date'].toString()}\n',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ]),
                                                          ),

                                                          
                                                        ],
                                                      ),
                                                    ),
                                                    
                                                  ],
                                                ),
                                                Container(
                                                  child: Divider(
                                                      color: Colors.white,
                                                      endIndent: 15,
                                                      height: 12,
                                                      thickness: 10),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'ToTal',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              'ff9900'),
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      width: 160,
                                                    ),
                                                    Text(
                                                      '${(double.parse(data['price']) * data['products']['quantity']).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              'ff9900'),
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );

                                  // return ListView.builder(
                                  //   itemCount: snapshot.data!.docs.length,
                                  //   itemBuilder: (BuildContext context, int index) {
                                  //     var doc = snapshot.data!.docs[index];

                                  //     var data = doc.data() as Map;
                                  //     // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                                  //     //   var doc = snapshot.data!.docs[i];

                                  //     //   var data = doc.data() as Map;
                                  //     //   countofelement +=
                                  //     //       data['products']['quantity'] as int;
                                  //     //   print(countofelement);

                                  //     //   var quantityElemnt =
                                  //     //       data['products']['quantity'] as int;
                                  //     //   double PriceElemnt = double.parse(data['price']);
                                  //     //   totleprice += (quantityElemnt * PriceElemnt);
                                  //     //   var totleprice1 = totleprice;
                                  //     //   print(totleprice);

                                  //     //   print(totleprice);
                                  //     // }
                                  //     // countofelement += data['products']['quantity'] as int;
                                  //     // print(countofelement);

                                  //     // var quantityElemnt =
                                  //     //     data['products']['quantity'] as int;
                                  //     // double PriceElemnt = double.parse(data['price']);
                                  //     // totleprice += (quantityElemnt * PriceElemnt);
                                  //     // print(totleprice);

                                  //     // print(totleprice);
                                  //     // totleprice+=;

                                  //   },
                                  // );
                                }
                              }),
                        ),
                  
                         SizedBox(
                          height: 15,
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
                        countofelement += data['products']['quantity'] as int;
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Row(
              children: [
                Expanded(child:  Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: HexColor('ff9900'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                                    showDialog(context: context,builder: (BuildContext context) {
        return AlertDialog(
          
          title: const Text('Conform Order'),
          content: const Text('your order take about 3-5 days'),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Text('Address'),
            Text('${data['address']['city']} ${data['address']['street']}'),

            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('cancle'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Buy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
              ],
            )
          ],
        );
      },
     );
                },
                child: Text(
                  'Order Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ),
             SizedBox(
              width: 10,
            ),
            Expanded(child:  Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {

                },
                child: Text(
                  'Cancle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),)
              ],
            )
                      ],
                    ),
                  );
                }
              }),
        ],
      )),
    );
  }
}
