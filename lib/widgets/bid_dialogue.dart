import 'package:flutter/material.dart';

import 'bidbutton.dart';

class bidDialogue extends StatelessWidget {
  final String title;
  const bidDialogue({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        BidButton(
          buttonTitle: "close",
          onPress: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
