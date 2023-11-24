import 'dart:ffi';

import 'package:auction_fire/screens/user_screens/bottom_tab_screens/cart_screen.dart';
import 'package:auction_fire/screens/user_screens/bottom_tab_screens/favourite_screen.dart';
import 'package:auction_fire/screens/user_screens/seller_pages/seller_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bottomPageScreen extends StatefulWidget {
  final User? user;
  const bottomPageScreen({super.key, this.user});

  @override
  State<bottomPageScreen> createState() => _bottomPageScreenState();
}

class _bottomPageScreenState extends State<bottomPageScreen> {
  int ProcartNo = 0;

  //to show dynamically number of products added to cart
  void cartItemsLength() {
    FirebaseFirestore.instance.collection("Cart").get().then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          ProcartNo = snap.docs.length;
        });
      } else {
        setState(() {
          ProcartNo = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cartItemsLength();
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Stack(
            children: [
              Icon(Icons.add_shopping_cart_rounded),
              //position of black point which show
              // how many item are added to user cart
              Positioned(
                  bottom: 1,
                  right: -4,
                  child: ProcartNo == 0 ? 
                        Container() : 
                   Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20,
                        color: Colors.black,
                      ),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "$ProcartNo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    ],
                  ))
            ],
          )),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                    child: SellerHomeScreen(
                      user: widget.user,
                    ),
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
          return SellerHomeScreen(user: widget.user);
        });
  }
}
