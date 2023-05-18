import 'package:auction_fire/screens/login_page.dart';
import 'package:auction_fire/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color.fromARGB(255, 156, 113, 98),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: 'LoginPage',
    routes: {
      'LoginPage': (context) => LoginPage(),
      'SignUp': (context) => SignUp()
    },
  ));
}
