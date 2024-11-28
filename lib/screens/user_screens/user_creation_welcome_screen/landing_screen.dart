import 'package:auction_fire/screens/user_screens/bottom_tab_screens/bottom_page.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/guest_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../widgets/styles.dart';

class LandiingScreen extends StatelessWidget {
  Future<FirebaseApp> initialize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder:
                (BuildContext context, AsyncSnapshot<User?> streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("${streamSnapshot.error}"),
                  ),
                );
              }

              if (streamSnapshot.connectionState == ConnectionState.active) {
                User? user = streamSnapshot.data;

                if (user == null) {
                  return GuestPage();
                } else {
                  return bottomPageScreen(
                    user: user,
                  );
                }
              }

              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Auction ",
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "FIRE",
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            },
          );
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
