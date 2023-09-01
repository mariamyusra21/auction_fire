import 'package:auction_fire/screens/landing_screen.dart';
import 'package:flutter/material.dart';

import 'admin_screens/web_login.dart';

class Layout_Screen extends StatelessWidget {
  const Layout_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //contraints check the max and min height, width of the screen on which app is running
      if (constraints.maxWidth < 700) {
        return LandiingScreen();
      } else {
        return WebLoginScreen();
      }
    });
  }
}
