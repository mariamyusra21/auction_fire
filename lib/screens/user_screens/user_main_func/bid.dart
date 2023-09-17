import 'package:auction_fire/models/add_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BidPage extends StatefulWidget {
  // final String? productId;
  final Uploadproduct product;

  BidPage({super.key, required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<BidPage> {
  final TextEditingController bidController = TextEditingController();
  double? currentHighestBid;

  @override
  void initState() {
    super.initState();
    // Fetch the current highest bid when the page loads
    fetchCurrentHighestBid();
  }

  void fetchCurrentHighestBid() async {
    // Fetch the current highest bid from Firestore
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('Updateproduct')
        .doc(widget.product.id)
        .get();

    setState(() {
      currentHighestBid = documentSnapshot['currentHighestBid'];
    });
  }

  void placeBid() async {
    final double userBid = double.parse(bidController.text);

    if (currentHighestBid == null || userBid >= currentHighestBid!) {
      // Update the current highest bid in Firestore
      await FirebaseFirestore.instance
          .collection('Updateproduct')
          .doc(widget.product.id)
          .update({'currentHighestBid': userBid});

      // Store the user's bid in a separate bids collection if needed
      // FirebaseFirestore.instance.collection('bids').add({
      //   'productId': widget.productId,
      //   'userId': 'user_id_here', // Replace with user's ID
      //   'bidAmount': userBid,
      // });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bid placed successfully!'),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Invalid Bid'),
            content:
                Text('Your bid must be higher than the current highest bid.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Current Highest Bid: ${currentHighestBid ?? 'N/A'}'),
            TextField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Your Bid'),
            ),
            ElevatedButton(
              onPressed: placeBid,
              child: Text('Place Bid'),
            ),
          ],
        ),
      ),
    );
  }
}
