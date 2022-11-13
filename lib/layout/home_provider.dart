// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:math';
import 'dart:typed_data';

import 'package:amazon_app/modules/addtocart/addtocart.dart';
import 'package:amazon_app/modules/checkout/checkout.dart';
import 'package:amazon_app/modules/orders/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:amazon_app/models/cart_model.dart';
import 'package:amazon_app/models/products_model.dart';
import 'package:amazon_app/models/user_profile.dart';
import 'package:amazon_app/modules/home/home.dart';
import 'package:amazon_app/modules/profile/setting_screen.dart';
import 'package:amazon_app/shared/components/components.dart';
import 'package:amazon_app/shared/network/local/cashe_helper.dart';
import 'package:amazon_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:amazon_app/utils/ar.dart';
import 'package:amazon_app/utils/en.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class HomeProvider with ChangeNotifier {
  int currentIndex = 0;

  List<Widget> listScreen = [
    InterHomeScreen(),
    GetCart(),
    CheckoutScreen(),
    orderScreen(),
    SettingsScreen(),
  ];

  void changeNav(index) {
    currentIndex = index;
    notifyListeners();
  }

  List<String?> categories = [];
  dynamic selectedCat;
  void changeCat(String cat) {
    selectedCat = cat;
    notifyListeners();
  }

  List<CartModel> _items = [];
  List<CartModel> get items {
    // print(items);
    return _items;
  }

  // void addToCartt(
  //   String? userId,
  //   String? date,
  //   String? image,
  //   String? title,
  //   dynamic price,
  //   String? description,
  //   String? category,
  //   Products? products,
  // ) {
  //   String id = FirebaseAuth.instance.currentUser!.uid;
  //   final ref = FirebaseFirestore.instance
  //       .collection('v')
  //       .doc(id)
  //       .collection('mycarts')
  //       .snapshots();

  //   _items.add(
  //     CartModel(
  //       userId: userId,
  //       date: date,
  //       products: products,
  //       category: category,
  //       description: description,
  //       image: image,
  //       price: price,
  //       title: title,
  //     ),
  //   );
  // }

  // double total(double price, Products products) {
  //   double total = 0.0;
  //   total += (products.quantity! * price);
  //   return total;
  // }

  CartModel findElement(int id) {
    return _items.firstWhere((element) => element.products!.productId == id);
  }

  Future<void> getCategories() async {
    categories = [];
    await DioHelper.getData(url: 'products').then((value) {
      ModelProducts modelProducts = ModelProducts.fromjson(value.data);
      selectedCat = modelProducts.products[0].category;
      for (var val in modelProducts.products) {
        if (!categories.contains(val.category)) {
          categories.add(val.category);
        }
      }
      print(categories[1]);
    }).catchError((onError) {
      print(onError.toString());
    });
    notifyListeners();
  }

  List<ProductsModel> productsBasedCategories = [];
  Future<List<ProductsModel>> getProducts(String cat) async {
    productsBasedCategories = [];
    await DioHelper.getData(url: 'products').then((value) {
      ModelProducts modelProducts = ModelProducts.fromjson(value.data);
      productsBasedCategories = [];
      for (var val in modelProducts.products) {
        if (val.category == cat) {
          productsBasedCategories.add(val);
          print(val.title);
        }
      }
    }).catchError((onError) {
      print(onError.toString());
    });
    return productsBasedCategories;
    notifyListeners();
  }

  //change lang
  dynamic myLang = SharedHelper.get(key: 'lang');

  void changeLanguage(String lang) async {
    myLang = lang;
    Get.updateLocale(Locale(lang));
    SharedHelper.save(value: lang, key: 'lang');
    notifyListeners();
  }

//current user
  UserProfile? userProfile;

  void getUserProfile() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .snapshots()
        .listen((event) {
      userProfile = UserProfile.fromJson(event.data());
      // notifyListeners();
    }).onError((handleError) {
      print(handleError.toString());
      notifyListeners();
    });
  }

  dynamic mode;
  void modeChange(context) {
    if (SharedHelper.get(key: 'theme') == 'Light Theme') {
      SharedHelper.save(value: 'Dark Theme', key: 'theme');
      mode = 'dark';
    } else {
      mode = 'light';
      SharedHelper.save(value: 'Light Theme', key: 'theme');
    }
    Phoenix.rebirth(context);
    notifyListeners();
  }

  void changeSettings(context) {
    Navigator.pop(context);
    changeNav(1);
  }

  //profile
  void navigte(context) {
    Navigator.of(context);
    notifyListeners();
  }

//location permission
  final Location location = Location();

  PermissionStatus? _permissionGranted;

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await location.hasPermission();
    _permissionGranted = permissionGrantedResult;
    notifyListeners();
  }

  Future<void> requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      _permissionGranted = permissionRequestedResult;
      notifyListeners();
    }
  }
  //address

  Marker? origin;
  Circle? circle;
  GoogleMapController? googleMapController;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(52.2165157, 6.9437819),
    zoom: 14.4746,
  );

  void onMapCreated(GoogleMapController MapController) {
    googleMapController = MapController;
  }

  LocationData? currLocation;
  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load('assets/images/marker.png');
    return byteData.buffer.asUint8List();
  }

  Future<void> getCurrentLocation() async {
    Uint8List imageData = await getMarker();
    currLocation = await Location().getLocation();
    LatLng latLng = LatLng(
        currLocation!.latitude as double, currLocation!.longitude as double);
    cameraPosition = CameraPosition(target: latLng, zoom: 18);
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLng, zoom: 18),
    ));
    await updateCurrentLocation(imageData, currLocation!);
    notifyListeners();
  }

  Future<void> updateCurrentLocation(
      Uint8List imageData, LocationData location) async {
    LatLng latLng =
        LatLng(location.latitude as double, location.longitude as double);
    origin = Marker(
      markerId: const MarkerId('me'),
      position: latLng,
      icon: BitmapDescriptor.fromBytes(imageData),
      flat: true,
      draggable: false,
      zIndex: 2,
      rotation: location.heading as double,
    );
    circle = Circle(
      circleId: const CircleId('car'),
      center: latLng,
      radius: location.accuracy as double,
      strokeColor: Colors.black,
      strokeWidth: 2,
      zIndex: 1,
      fillColor: Colors.purple.withAlpha(60),
    );
    notifyListeners();
  }

  //user edit user data
  void editUser() async {
    print(userProfile);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .set(userProfile!.toJson())
        .then((value) {
      showToast(message: 'Edited Successfully', state: ToastState.SUCCESS);
      notifyListeners();
    }).catchError((onError) {
      print(onError.toString());
      showToast(message: onError.toString(), state: ToastState.ERROR);
      notifyListeners();
    });
  }

  //cart
  Map<String, int> cartMap = Map();

  void addToCart(CartModel cartModel, int productId, String image, String title,
      dynamic price, String description, String? category, bool edit) async {
    FirebaseFirestore.instance
        .collection('v')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('mycarts')
        .add(cartModel.toJson())
        .then((value) {
      if (!edit) {
        showToast(message: 'Added Successfully', state: ToastState.SUCCESS);
      } else {
        showToast(message: 'Edited Successfully', state: ToastState.SUCCESS);
      }
      notifyListeners();
    }).catchError((onError) {
      printError(info: onError.toString());
      showToast(message: onError.toString(), state: ToastState.ERROR);
      notifyListeners();
    });
  }

  String id = FirebaseAuth.instance.currentUser!.uid;
  
  Stream<QuerySnapshot> getproductsAddedToFireStore() async* {
    yield* FirebaseFirestore.instance
        .collection('v')
        .doc(id)
        .collection('mycarts')
        .snapshots();
  }

  int countofelement = 0;
  double totleprice = 0.0;

  Future<List<CartModel>> getUserTaskList() async {
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('v')
        .doc(id)
        .collection('mycarts')
        .get();

    return qShot.docs
        .map((doc) => CartModel(
            date: doc['date'],
            products: doc['products'],
            userId: doc['userId'],
            category: doc['category'],
            description: doc['description'],
            image: doc['image'],
            price: doc['price'],
            title: doc['title']))
        .toList();
  }

  List<String> countofEE = [];
  get countofEE1 => countofEE;

//   totalprice11() async {
//     List<CartModel> tasks = await getUserTaskList();

//     tasks.forEach((element) {
//       var e = element.title;
//       print('qqqqq $e');
//       countofEE.add(e!);
//     });
//     countofEE = countofEE;
//     notifyListeners();
//   }

//   void totalPrice() {
//     var snapshot1 = getproductsAddedToFireStore();
//     StreamBuilder(
//       stream: snapshot1,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Text("Loading");
//         } else {
//           print("snapshot:: data >>>> ${snapshot.data!.docs}");
//           for (int i = 0; i < snapshot.data!.docs.length; i++) {
//             var doc = snapshot.data!.docs[i];

//             var data = doc.data() as Map;
//             countofelement += data['products']['quantity'] as int;
//             print(countofelement);

//             var quantityElemnt = data['products']['quantity'] as int;
//             double PriceElemnt = double.parse(data['price']);
//             totleprice += (quantityElemnt * PriceElemnt);
//             var totleprice1 = totleprice.toStringAsPrecision(2);
//             print(totleprice);

//             print(totleprice);
//             return Text('data');
//           }
//         }
//         return Text('');
//       },
//     );
//     notifyListeners();
//   }

//   get _countofelement {
//     return countofelement;
//     notifyListeners();
//   }
}




