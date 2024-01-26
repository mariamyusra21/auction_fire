import 'package:auction_fire/screens/admin_screens/web_main.dart';
import 'package:auction_fire/screens/profile/user_profile.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/layout_screen.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/login_page.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:sizer/sizer.dart';

final String paymobApi =
    'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRJM05ERTJMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuaUZFeGVEaVppLWVwd1FCRzNqbm1UMjBuTF9wR08yZlJzcnZTMFZCQzZ4OWc1c1RtR2xnbWNMTXRyamlFeTBkVUEybVFNNG1TaUxpeWQwNTdMME4yN2c=';

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
    await PaymobPakistan.instance.initialize(
        apiKey: paymobApi,
        integrationID: 144948,
        iFrameID: 156276,
        jazzcashIntegrationId: 149385,
        easypaisaIntegrationID: 144948);
  }

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
