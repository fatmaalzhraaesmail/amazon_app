import 'dart:ui';

import 'package:amazon_app/pages/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class productsContainer extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  // final Function onpress;
  final String category;
  final num rating1;
  final num rating2;
  final String image;
  final num price;

  productsContainer({
    // required this.onpress,
    required this.id,
    required this.category,
    required this.rating1,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.rating2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              id: id,
              category: category,
              description: description,
              image: image,
              price: price,
              rating1: rating1,
              rating2: rating2,
              title: title,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 150,
                    // width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 300,
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    child: Text(
                  description,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis, color: Colors.black),
                )),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          rating1.toString(),
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RatingBar.builder(
                          initialRating: rating1.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 18,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating1) {
                            print(rating1);
                          },
                        ),
                      ],
                    ),
                    Text(
                      '$price \$'.toString(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
