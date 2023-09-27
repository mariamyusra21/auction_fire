import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerBidPage extends StatefulWidget {
  // final String? productId;
  // final Uploadproduct product;
  final DocumentSnapshot documentSnapshot;

  BuyerBidPage({super.key, required this.documentSnapshot});

  @override
  _BuyerBidPageState createState() => _BuyerBidPageState();
}

class _BuyerBidPageState extends State<BuyerBidPage> {
  final TextEditingController bidController = TextEditingController();
  int? currentHighestBid;

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
        .doc(widget.documentSnapshot.id)
        .get();

    setState(() {
      currentHighestBid = documentSnapshot['currentHighestBid'];
    });
  }

  void placeBid() async {
    final int userBid = int.parse(bidController.text);

    if (currentHighestBid == null || userBid >= currentHighestBid!) {
      // Update the current highest bid in Firestore
      await FirebaseFirestore.instance
          .collection('Updateproduct')
          .doc(widget.documentSnapshot.id)
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
        backgroundColor: Color(0xFFD45A2D),
        centerTitle: true,
        title: Text('Bidding Page'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFD45A2D),
          Color(0xFFBD861C),
          Color.fromARGB(67, 0, 130, 181)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Current Highest Bid: ${currentHighestBid ?? 'N/A'}'),
                TextField(
                  controller: bidController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Enter Your Bid'),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(colors: [
                          Color(0xFFD45A2D),
                          Color(0xFFBD861C),
                          Color.fromARGB(67, 0, 130, 181)
                        ])),
                    child: BidButton(
                      buttonTitle: "Place bid",
                      onPress: () async {
                        placeBid();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
