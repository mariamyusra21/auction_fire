import 'package:auction_fire/screens/admin_screens/web_main.dart';
import 'package:auction_fire/screens/layout_screen.dart';
import 'package:auction_fire/screens/login_page.dart';
import 'package:auction_fire/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB4Jz2bdb6MMaVksxaJdYafTX9RBpDk06k",
            authDomain: "fyp-auction-fire.firebaseapp.com",
            projectId: "fyp-auction-fire",
            storageBucket: "fyp-auction-fire.appspot.com",
            messagingSenderId: "812678785636",
            appId: "1:812678785636:web:d9f89cd19564b1e3d90d71"));
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  // ignore: unrelated_type_equality_checks
  // if (Firebase.apps.length == 0) {
  //   Firebase.initializeApp(
  //       options: FirebaseOptions(
  //           apiKey: "AIzaSyB4Jz2bdb6MMaVksxaJdYafTX9RBpDk06k",
  //           appId: "1:812678785636:web:d9f89cd19564b1e3d90d71",
  //           messagingSenderId: "812678785636",
  //           projectId: "fyp-auction-fire"));
  // }

  runApp(Sizer(
    builder: (context, orientation, deviceType) => MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 156, 113, 98),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'LayoutPage',
      routes: {
        'LayoutPage': (context) => Layout_Screen(),
        'LoginPage': (context) => LoginPage(),
        'SignUp': (context) => SignUp(),
        'webmain': (context) => WebMainScreen()
      },
    ),
  ));
}
