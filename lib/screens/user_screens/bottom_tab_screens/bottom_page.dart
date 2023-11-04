import 'package:auction_fire/screens/user_screens/bottom_tab_screens/cart_screen.dart';
import 'package:auction_fire/screens/user_screens/bottom_tab_screens/favourite_screen.dart';
import 'package:auction_fire/screens/user_screens/seller_pages/seller_home_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class bottomPageScreen extends StatefulWidget {
  const bottomPageScreen({super.key});

  @override
  State<bottomPageScreen> createState() => _bottomPageScreenState();
}

class _bottomPageScreenState extends State<bottomPageScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
            BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_rounded)),
    ]), 
    tabBuilder: (context, index){
      switch (index) {
        case 0:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                child: SellerHomeScreen(),
              );
            },
          );
          case 1:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                child: FavoriteScreen(),
              );
            },
          );
          case 2:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                child: CartScreen(),
              );
            },
          );
        default:
      }
      return SellerHomeScreen();
    });
  }
}