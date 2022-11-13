import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.grey,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 205, 165, 43),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  Color.fromARGB(255, 205, 165, 43),
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color:  Color.fromARGB(255, 205, 165, 43),
        ),
      ),
      
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.black,
        ),
        caption: TextStyle(
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
      ),
      hintColor: Colors.black,
      brightness: Brightness.light,
      primaryColor:  Color.fromARGB(255, 205, 165, 43),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
    );
ThemeData darkTheme() => ThemeData(
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor:HexColor('000000'),
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('202020'),
      elevation: 5,
      titleTextStyle: const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 205, 165, 43),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('000000'),
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),

    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        color: Colors.white,
      ),
      caption: TextStyle(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: HexColor('2f2f2f'),
    ),
    hintColor: Colors.white,
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    drawerTheme: DrawerThemeData(
      elevation: 0,
      backgroundColor: Colors.black,
    ),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: HexColor('000028')));
