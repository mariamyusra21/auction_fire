import 'package:auction_fire/screens/landing_screen.dart';
import 'package:auction_fire/screens/login_page.dart';
import 'package:auction_fire/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB4Jz2bdb6MMaVksxaJdYafTX9RBpDk06k",
          appId: "1:812678785636:web:d9f89cd19564b1e3d90d71",
          messagingSenderId: "812678785636",
          projectId: "fyp-auction-fire"));

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color.fromARGB(255, 156, 113, 98),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: 'LandingPage',
    routes: {
      'LandingPage': (context) => LandiingScreen(),
      'LoginPage': (context) => LoginPage(),
      'SignUp': (context) => SignUp()
    },
  ));
}
