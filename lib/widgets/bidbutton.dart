// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

class BidButton extends StatelessWidget {
  BidButton(
      {super.key,
      required this.buttonTitle,
      this.isLoginButton = false,
      this.onPress,
      this.isLoading = false,
      this.color});

  String buttonTitle;
  bool
      isLoginButton; // if button is login then either buttoncolor should be this(cyan) or that(black)
  VoidCallback? onPress;
  bool isLoading;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPress,
      child: Container(
          // color: color,
          margin: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical:
                  10), //verticle 10 create the create new account button on bottom
          decoration: BoxDecoration(
            color: isLoginButton == false ? Colors.transparent : Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 55,
          // text in button
          alignment: Alignment.center,
          child: Stack(
            children: [
              Visibility(
                visible: isLoading ? false : true,
                child: Center(
                  child: Text(
                    "$buttonTitle",
                    style: TextStyle(
                      fontSize: 24,
                      color:
                          isLoginButton == false ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          )),
    );
  }
}
