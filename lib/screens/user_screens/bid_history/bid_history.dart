import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BidHistory extends StatefulWidget {
  final DocumentSnapshot prodDoc;

  const BidHistory({Key? key, required this.prodDoc}) : super(key: key);

  @override
  State<BidHistory> createState() => _BidHistoryState();
}

class _BidHistoryState extends State<BidHistory> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          '${widget.prodDoc.get('productName')} Bids',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('bids')
                        .doc(widget.prodDoc.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data == null) {
                        return Center(child: Text('No bid history available.'));
                      }

                      final Map<String, dynamic>? data = snapshot.data!.data();
                      final List<dynamic> bidHistory =
                          data?['bidHistory'] ?? [];

                      return ListView.builder(
                        itemCount: bidHistory.length,
                        itemBuilder: (context, index) {
                          final bidEntry = bidHistory[index];

                          final String userID = bidEntry['userID'];
                          final int userBid = bidEntry['userBid'];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // color: Colors.primaries[Random().nextInt(10)],
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                    'User Name: $userID,\nBid Price: $userBid Rs/=',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
