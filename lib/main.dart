import 'dart:ffi';

import 'package:amazon_app/models/cart.dart';
import 'package:amazon_app/pages/ProductDetails.dart';
import 'package:amazon_app/pages/ProductDetailsScreen1.dart';
import 'package:amazon_app/pages/homepage.dart';
import 'package:amazon_app/pages/navigator.dart';
import 'package:amazon_app/pages/productlist.dart';
import 'package:amazon_app/pages/signup.dart';
import 'package:amazon_app/services/Auth_Services.dart';
import 'package:amazon_app/widget/productscontainer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:onboarding/onboarding.dart';
import 'package:provider/provider.dart';
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUP();
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = NavigatorScreen();
      });
    }
  }

  Widget build(BuildContext context) {
     return ChangeNotifierProvider(create: (context) {
        return Cart();
      },
      
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'smart home',
        home: SignUP(),
      ),
    
    );
  }
}
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
      
//       // home: NavigatorScreen(),
//       home: NavigatorScreen(),
//     );
//   }
// }
