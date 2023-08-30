import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import 'home_screen.dart';
import 'login_page.dart';

// ignore: must_be_immutable
class LandiingScreen extends StatelessWidget {
  // const LandiingScreen({super.key});

  // to initialize app in firebase
  Future<FirebaseApp> initialize = Firebase.initializeApp();

  LandiingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //a widget that responds to changes in state or dependencies by building itself
    //based on the most recent snapshot of a Future
    return FutureBuilder(
      future: initialize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //agr koi error aye example internet issue then ye if wala block chale
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        //it will check wheather the app is connected to firebase or not, if not show error
        if (snapshot.connectionState == ConnectionState.done) {
          //rebuild everytime for every new events mtlb har state ke liye rebuild hoga
          return StreamBuilder(
              stream: FirebaseAuth.instance
                  .authStateChanges(), //check auth state changes
              // ignore: non_constant_identifier_names
              builder: (BuildContext context, AsyncSnapshot StreamSnapshot) {
                if (StreamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("${StreamSnapshot.error}"),
                    ),
                  );
                }
                //if connection will go active what will be shown on display screen
                if (StreamSnapshot.connectionState == ConnectionState.active) {
                  User? user = StreamSnapshot
                      .data; //if above cond true save data in user object

                  if (user == null) {
                    return LoginPage();
                  } else {
                    return HomeScreen();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Authentication Checking',
                          style: BidStyle.boldStyle,
                          textAlign: TextAlign.center,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: BidStyle.boldStyle,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
