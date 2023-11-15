import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyerBidPage extends StatefulWidget {
  final DocumentSnapshot prodDoc;
  final User? user;

  BuyerBidPage({super.key, required this.prodDoc, this.user});

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

  Future<BidData?> fetchCurrentHighestBid() async {
    try {
      // Fetch the current bid document from Firestore
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('bids')
          .doc(widget.prodDoc.id)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract bidHistory array from the document
        List<Map<String, dynamic>> bidHistory = List<Map<String, dynamic>>.from(
          documentSnapshot['bidHistory'] ?? [],
        );

        // Find the highest bid value
        int highestBid = 0; // Initialize with a default value
        String userId = '';

        bidHistory.forEach((bid) {
          final int userBid = bid['userBid'];
          final String currentUserId = bid['userID'];

          if (userBid > highestBid) {
            highestBid = userBid;
            userId = currentUserId;
          }
        });

        setState(() {
          // Set currentHighestBid to highestBid
          currentHighestBid = highestBid;
        });

        return BidData(userId, highestBid);
      } else {
        // Handle the case where the document doesn't exist
        print('Document does not exist');
        documentSnapshot = await FirebaseFirestore.instance
            .collection('Updateproduct')
            .doc(widget.prodDoc.id)
            .get();

        setState(() {
          currentHighestBid = documentSnapshot['currentHighestBid'];
        });
        return null;
      }
    } catch (e) {
      // Handle any errors that may occur during the fetch operation
      print('Error fetching bid document: $e');
      return null;
    }
  }

  void placeBid() async {
    final int userBid = int.parse(bidController.text);

    if (currentHighestBid == null || userBid >= currentHighestBid!) {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('bids')
          .doc(widget.prodDoc.id)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // update the bidDocument for bidHistory
        FirebaseFirestore.instance
            .collection('bids')
            .doc(widget.prodDoc.id)
            .update({
          'productName': '${widget.prodDoc.get('productName')}',
          'bidHistory': FieldValue.arrayUnion([
            {
              'userID': '${widget.user?.uid}',
              'userBid': userBid,
            }
          ]),
        });
      } else {
        // create the bidDocument for bidHistory
        FirebaseFirestore.instance
            .collection('bids')
            .doc(widget.prodDoc.id)
            .set({
          'productName': '${widget.prodDoc.get('productName')}',
          'bidHistory': FieldValue.arrayUnion([
            {
              'userID': '${widget.user?.uid}',
              'userBid': userBid,
            }
          ]),
        });
      }

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
        title: Text('Bid Time'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD45A2D),
              Color(0xFFBD861C),
              Color.fromARGB(67, 0, 130, 181)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFD45A2D),
                          Color(0xFFBD861C),
                          Color.fromARGB(67, 0, 130, 181)
                        ],
                      ),
                    ),
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

class BidData {
  final String userId;
  final int userBid;

  BidData(this.userId, this.userBid);
}
