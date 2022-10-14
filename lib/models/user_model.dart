import 'dart:math';

import 'package:flutter/material.dart';

class UserModel {
  String? userId, email, pic;
  UserModel(
      { this.email='',
       
       this.pic='',
       this.userId=''});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    pic = map['pic'];
    // userId = map['userId'];
    
  }

  toJson() {
    return {'userId': userId, 'email': email, 'pic': pic, };
  }
}
