import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amazon_app/layout/home_provider.dart';
import 'package:amazon_app/modules/login/login_screen.dart';
import 'package:amazon_app/shared/components/components.dart';
import 'package:amazon_app/shared/network/local/cashe_helper.dart';
import 'package:amazon_app/utils/ar.dart';
import 'package:amazon_app/utils/en.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<String> appbartitle = [
    'SOUQ',
    'Cart',
    'Check Out',
    'Order',
    'Account',

  ];
  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<HomeProvider>(context, listen: true);
    return Builder(builder: (context) {
      Provider.of<HomeProvider>(context, listen: false).getUserProfile();
      return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.black45,
          centerTitle: true,
          title:  Text(
            appbartitle[obj.currentIndex],
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 3),
              child: Container(
                 width: 50,
                child: Image.asset(
                  "assets/images/amazon-black-icon-16.png",
                  // fit: BoxFit.cover,
                  // width: 100,
                ),
              ),
            ),
          ],
        ),
        body: obj.listScreen[obj.currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          height: 55.0,
          color: Colors.black,
          backgroundColor: Color.fromARGB(255, 240, 238, 238),
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
              semanticLabel: SharedHelper.get(key: 'lang') == 'en'
                  ? en['Home']!
                  : ar['Home']!,
              // label:SharedHelper.get(key: 'lang')=='en'?en['Home']!:ar['Home']!
            ),
            Icon(
                 Icons.local_grocery_store_outlined ,
              color: Colors.white,
              semanticLabel: SharedHelper.get(key: 'lang') == 'en'
                  ? en['Cart']!
                  : ar['Cart']!,
              // label:SharedHelper.get(key: 'lang')=='en'?en['Home']!:ar['Home']!
            ),
            Icon(
           Icons.list_alt_sharp,
              color: Colors.white,
              semanticLabel: SharedHelper.get(key: 'lang') == 'en'
                  ? en['Checkout']!
                  : ar['Checkout']!,
              // label:SharedHelper.get(key: 'lang')=='en'?en['Home']!:ar['Home']!
            ),
            Icon(
              Icons.badge_sharp,
              color: Colors.white,
              semanticLabel: SharedHelper.get(key: 'lang') == 'en'
                  ? en['Orders']!
                  : ar['Orders']!,
              // label:SharedHelper.get(key: 'lang')=='en'?en['Home']!:ar['Home']!
            ),
            Icon(
              Icons.person_outlined,
              color: Colors.white,
              semanticLabel: SharedHelper.get(key: 'lang') == 'en'
                  ? en['Profile']!
                  : ar['Profile']!,
            ),
          ],
          onTap: (index) {
            Provider.of<HomeProvider>(context, listen: false).changeNav(index);
          },
        ),
        drawer: Drawer(
          //end drawer right english w drawer left arabic
          child: Column(
            children: [
              if (obj.userProfile != null)
                UserAccountsDrawerHeader(
                  accountName: Text(
                    obj.userProfile!.username,
                    style: SharedHelper.get(key: "theme") == 'Light Theme'
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)
                        : TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: HexColor('000028')),
                  ),
                  accountEmail: Text(
                    obj.userProfile!.email,
                    style: SharedHelper.get(key: "theme") == 'Light Theme'
                        ? const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white)
                        : TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: HexColor('000028')),
                  ),
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 22, bottom: 10, top: 22),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 11,
                          backgroundColor:
                              SharedHelper.get(key: 'theme') == 'Light Theme'
                                  ?  Color.fromARGB(255, 205, 165, 43)
                                  :  Color.fromARGB(255, 205, 165, 43),
                          child: Icon(
                            Icons.dark_mode_outlined,
                            color:
                                SharedHelper.get(key: 'theme') == 'Light Theme'
                                    ? Colors.black
                                    : Colors.white,
                            size: 15,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        SharedHelper.get(key: 'theme') == 'Light Theme'
                            ? (SharedHelper.get(key: 'lang') == 'en'
                                ? en['Light Theme']!
                                : ar['Light Theme']!)
                            : (SharedHelper.get(key: 'lang') == 'en'
                                ? en['Dark Theme']!
                                : ar['Dark Theme']!),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .modeChange(context);
                  Provider.of<HomeProvider>(context, listen: true).mode;
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 22, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.settings,
                        size: 20,
                        color:  Color.fromARGB(255, 205, 165, 43),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        SharedHelper.get(key: 'lang') == 'en'
                            ? en['Settings']!
                            : ar['Settings']!,
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .changeSettings(context);
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 22, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 20,
                        color:  Color.fromARGB(255, 205, 165, 43),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        SharedHelper.get(key: 'lang') == 'en'
                            ? en['Log Out']!
                            : ar['Log Out']!,
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  SharedHelper.remove(key: 'signIn');
                  SharedHelper.remove(key: 'uid');
                  navigateToWithoutReturn(context, LogInScreen());
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
