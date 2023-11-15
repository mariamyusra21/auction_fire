import 'dart:math';

import 'package:auction_fire/screens/user_screens/bid_history/bid_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductsBidList extends StatefulWidget {
  const ProductsBidList({super.key});

  @override
  State<ProductsBidList> createState() => _ProductsBidListState();
}

class _ProductsBidListState extends State<ProductsBidList> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'Products Bids List',
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
                gradient: LinearGradient(colors: [
              Color(0xFFD45A2D),
              Color(0xFFBD861C),
              Color.fromARGB(67, 0, 130, 181)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Updateproduct')
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            docs = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (_, index) {
                            final doc = docs[index];
                            final productName = doc.data()["productName"];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                // color: Colors.white,
                                color: Colors.primaries[Random().nextInt(5)],
                                child: ListTile(
                                  title: Text('${index + 1}. $productName',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22)),

                                  trailing: TextButton(
                                    child: Text('View Bids',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BidHistory(prodDoc: doc)));
                                    },
                                  ),

                                  // onTap Navigation is not required in seller page...
                                  // onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             BidHistory(prodDoc: doc))),
                                ),
                              ),
                            );
                          },
                        );
                      }
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
