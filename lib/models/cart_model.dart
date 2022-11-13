import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CartModel {
  String? userId;
  String? date;
  String? image;
  String? title;
  dynamic price;
  String? description;
  String? category;

  Products? products;
  
  CartModel({required this.userId,required this.date, this.image,required this.products,this.category,this.description,this.price,this.title});
  // CartModel.fromMap(Map snapshot,String userId) :
  //       userId = userId ?? '',
  //       date= snapshot['date'] ?? '',
  //       image = snapshot['image'] ?? '',
  //       category = snapshot['category'] ?? '',
  //       title= snapshot['title'] ?? '',
  //       price= snapshot['price'] ?? '',
  //       description= snapshot['description'] ?? '';
  //       if(snapshot['products'] != null) {
  //     products =Products.fromJson(snapshot['products']);
  //   }
factory CartModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CartModel(
      userId: data?['userId'],
      date: data?['date'],
      image: data?['image'],
      title: data?['title'],
      price: data?['price'],
      category: data?['category'],
       products: data?['products'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (date != null) "date": date,
      if (image != null) "image": image,
      if (title != null) "title": title,
      if (price != null) "price": price,
      if (category != null) "category": category,
      if (products != null) "products": products,
 

    };
  }
  CartModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    if (json['products'] != null) {
      products =Products.fromJson(json['products']);
    }
  }


 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userId'] = userId;
    data['date'] = date;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    
    data['products']=products!.toJson();
    return data;
  }
}

class Products {
  int? productId;
  int? quantity;

  Products({this.productId, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }





  
}
