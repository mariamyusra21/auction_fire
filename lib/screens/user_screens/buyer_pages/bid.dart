import 'dart:async';

import 'package:auction_fire/services/utilities.dart';
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
  Timer? bidTimer;
  bool isTimerStarted = false;
  Duration remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    // Fetch the current highest bid when the page loads
    fetchCurrentHighestBid();
  }

  Future<void> fetchCurrentHighestBid() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('bids')
          .doc(widget.prodDoc.id)
          .get();

      if (documentSnapshot.exists) {
        List<Map<String, dynamic>> bidHistory = List<Map<String, dynamic>>.from(
          documentSnapshot['bidHistory'] ?? [],
        );

        int highestBid = 0;
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
          currentHighestBid = highestBid;
        });

        // Start the bid timer if it hasn't been started yet
        if (!isTimerStarted && currentHighestBid != null) {
          // Check if this is the first bid and add 24 hours to the bid end time
          if (bidHistory.isEmpty) {
            final DateTime bidEndTime = DateTime.now().add(Duration(hours: 24));
            await add24HoursToBidEndTime(
                documentSnapshot.reference, bidEndTime);
            startBidTimer(bidEndTime);
          } else {
            // Use the bid end time retrieved from Firestore
            final DateTime bidEndTime = documentSnapshot['bidEndTime'].toDate();
            startBidTimer(bidEndTime);
          }
        }
      } else {
        print('Document does not exist');
        documentSnapshot = await FirebaseFirestore.instance
            .collection('Updateproduct')
            .doc(widget.prodDoc.id)
            .get();

        setState(() {
          currentHighestBid = documentSnapshot['currentHighestBid'];
        });
      }
    } catch (e) {
      print('Error fetching bid document: $e');
      Utilities().toastMessage('Error fetching bid document: $e');
    }
  }

  Future<void> add24HoursToBidEndTime(
      DocumentReference bidReference, DateTime bidEndTime) async {
    // Update the bid document with the new bid end time
    await bidReference.update({'bidEndTime': bidEndTime});
  }

  void startBidTimer(DateTime bidEndTime) {
    isTimerStarted = true;

    remainingTime = bidEndTime.difference(DateTime.now());

    bidTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = bidEndTime.difference(DateTime.now());
      });

      if (remainingTime.isNegative) {
        timer.cancel();
        setState(() {
          remainingTime = Duration.zero;
          isTimerStarted = false;
        });
        print('Bid timer expired!');
        // Additional actions when the timer expires can be added here
      }
    });
  }

  void placeBid() async {
    final int userBid = int.parse(bidController.text);

    if (currentHighestBid == null || userBid >= (currentHighestBid! + 50)) {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('bids')
          .doc(widget.prodDoc.id)
          .get();

      if (documentSnapshot.exists) {
        FirebaseFirestore.instance
            .collection('bids')
            .doc(widget.prodDoc.id)
            .update({
          'productName': '${widget.prodDoc.get('productName')}',
          'bidHistory': FieldValue.arrayUnion([
            {
              'userID': '${widget.user?.displayName}',
              'userBid': userBid,
              'userEmail': '${widget.user?.email}'
            }
          ]),
        });

        FirebaseFirestore.instance
            .collection('Updateproduct')
            .doc(widget.prodDoc.id)
            .update({
          'currentHighestBid': userBid,
        });
      } else {
        FirebaseFirestore.instance
            .collection('bids')
            .doc(widget.prodDoc.id)
            .set({
          'productName': '${widget.prodDoc.get('productName')}',
          'bidHistory': FieldValue.arrayUnion([
            {
              'userID': '${widget.user?.displayName}',
              'userBid': userBid,
              'userEmail': '${widget.user?.email}'
            }
          ]),
          'bidEndTime': DateTime.now().add(Duration(hours: 24)),
          // Add the bid timer of 24 hours to Firestore...
        });

        FirebaseFirestore.instance
            .collection('Updateproduct')
            .doc(widget.prodDoc.id)
            .update({
          'currentHighestBid': userBid,
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
            content: Text(
                'Your bid must be higher than 50 Rs of current highest bid.'),
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
    bool isBidButtonActive = isTimerStarted && remainingTime.inSeconds >= 0;

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
              Color.fromARGB(67, 0, 130, 181),
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
                Text(
                  'Remaining Time: ${remainingTime.inHours}h ${remainingTime.inMinutes.remainder(60)}m ${remainingTime.inSeconds.remainder(60)}s',
                  style: TextStyle(fontSize: 18),
                ),
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
                          Color.fromARGB(67, 0, 130, 181),
                        ],
                      ),
                    ),
                    child: GestureDetector(
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
                              Color.fromARGB(67, 0, 130, 181),
                            ],
                          ),
                        ),
                        child: BidButton(
                          buttonTitle: "Place bid",
                          onPress: () async {
                            // if (isBidButtonActive) {
                            // Allow placing bid
                            placeBid();
                            // } else {
                            //   // Inactivate bid button if time has expired
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: Text('Bid Time Expired'),
                            //         content: Text('The bid time has expired.'),
                            //         actions: <Widget>[
                            //           TextButton(
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //             child: Text('OK'),
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   );
                            // }
                          },
                        ),
                      ),
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

  @override
  void dispose() {
    bidTimer?.cancel();
    super.dispose();
  }
}

class BidData {
  final String userId;
  final int userBid;

  BidData(this.userId, this.userBid);
}
