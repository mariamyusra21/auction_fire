import 'package:auction_fire/widgets/styles.dart';
import 'package:flutter/material.dart';

class Home_Cards extends StatelessWidget {
  final String title;
  const Home_Cards({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Colors.redAccent.withOpacity(0.4),
              Colors.blueAccent.withOpacity(0.4)
            ])),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title ?? "Title",
              style: BidStyle.boldStyle.copyWith(
                  // we use copywith when we want to change any property of class in only that widget
                  color: Colors.white)),
        ),
      ),
    );
  }
}
