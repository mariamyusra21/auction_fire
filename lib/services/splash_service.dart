import 'package:auction_fire/screens/user_screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      // if user is login then go to PostScreen...
      Future.delayed(Duration(seconds: 3), () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else {
      // if user is not loged in then login first...
      Future.delayed(Duration(seconds: 3), () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}
