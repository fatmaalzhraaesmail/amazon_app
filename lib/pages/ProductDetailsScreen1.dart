import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen1 extends StatefulWidget {
  
  const ProductDetailsScreen1({super.key});

  @override
  State<ProductDetailsScreen1> createState() => _ProductDetailsScreen1State();
}

class _ProductDetailsScreen1State extends State<ProductDetailsScreen1> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
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
                            height: 240,
                            child: Image.asset("assets/amazon-black-icon-16.png"),
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
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              onRatingUpdate: (rating1) {
                                print(rating1);
                              },
                            ),
                            Text(
                              " (134)",
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
                          "this is a sweat jaket ",
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
                          "\$ 6.299.85",
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
                          "bllllllllllllllllllaaaaa blaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
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
        SizedBox(height: 15,),
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
                            style: TextStyle(overflow: TextOverflow.clip ),
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

bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Expanded(child: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){},),),
            Expanded(child:ElevatedButton(

               style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20) )
                ),
              
              onPressed: (){},child: Text('Add To Cart',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),) ,),
            Expanded(child: IconButton(icon: Icon(Icons.list_alt),onPressed: (){},),),
          
          ],
        ),
        
      ),
      
    );
    
    
  }
  
}
