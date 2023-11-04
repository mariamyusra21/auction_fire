import 'package:auction_fire/screens/admin_screens/web_main.dart';
import 'package:auction_fire/screens/user_screens/signup_page.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/layout_screen.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/login_page.dart';
import 'package:auction_fire/screens/profile/user_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAysr0wEPpjqoiVcmHAluoZ_-KT_bjod_A",
            authDomain: "fyp-auction-fire-4c1ea.firebaseapp.com",
            projectId: "fyp-auction-fire-4c1ea",
            storageBucket: "fyp-auction-fire-4c1ea.appspot.com",
            messagingSenderId: "1010301042124",
            appId: "1:1010301042124:web:c778f85322ce4ff6a6b169"));
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
        'UserProfile': (context) => UserProfile(),
        'webmain': (context) => WebMainScreen()
      },
    ),
  ));
}
