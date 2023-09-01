import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class backGroundcolor extends StatelessWidget {
  const backGroundcolor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFD45A2D),
                Color(0xFFBD861C),
                Color.fromARGB(67, 0, 130, 181)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    );
  }
}