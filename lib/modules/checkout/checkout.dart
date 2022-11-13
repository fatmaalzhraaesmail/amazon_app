import 'package:amazon_app/layout/cartProvider.dart';
import 'package:amazon_app/layout/home_provider.dart';
import 'package:amazon_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  //   final CartModel order;
  // CheckoutScreen(this.order);
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
    double totleprice = 0.0;
  int countofelement = 0;
  @override
  Widget build(BuildContext context) {
    final cartData =
        Provider.of<HomeProvider>(context).getproductsAddedToFireStore;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                child: StreamBuilder(
                    stream: cartData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      } else {
                        print("snapshot:: data >>>> ${snapshot.data!.docs}");
                        return SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.27,
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
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
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
                                                  overflow: TextOverflow.ellipsis,
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
                                                                // overflow: TextOverflow.ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
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
                                                                'x${data['products']['quantity'].toString()}\n',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ]),
                                                ),
                                                
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      
                                      Container(
                                        child: Divider(
                                            color: Colors.white,endIndent: 15,height: 12,thickness: 10),
                                      ),
                                      Row(
                                       
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ToTal',
                                            style: TextStyle(
                                                color: HexColor('ff9900'),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 160,),
                                          Text(
                                           '${(double.parse(data['price']) * data['products']['quantity']).toStringAsFixed(2)}',
                                            style: TextStyle(
                                                color: HexColor('ff9900'),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
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
                              
                      
                      }
                    }),
              ),
  
                   Container(
                     child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Payment Method',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: HexColor('ff9900'),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  ),
                ],
              ),
                   ),

              Container(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/paypal.jpg',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'PayPal',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Method',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: HexColor('ff9900'),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                   color: HexColor('ebebeb'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reguler Shipping',
                            style: TextStyle(
                              fontSize: 20,
                              color: HexColor('ff9900'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Estimated 3-6 Days',style: TextStyle(
                            color: HexColor('ff9900'),
                          ),),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '\$3.00',
                        style: TextStyle(
                          color: HexColor('ff9900'),
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
                  
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping Fee',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '\$3.00',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price Total',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                    StreamBuilder(
                    stream: cartData(),
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
                        return Text(
                              '\$${totleprice.toStringAsFixed(2)}',
                              style: TextStyle(
                               color: Colors.grey,
                               fontWeight: FontWeight.bold,
                               fontSize: 23,
                              ),
                            );
                      }
                    }),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                             color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            // (total + 3.00).toStringAsFixed(2),
                            '${totleprice+3.00}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
     
    );
  }
}

