import 'dart:math';

import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/seller_pages/seller_product_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts({super.key});

  @override
  State<SellerProducts> createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'My Products',
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
                        .where('UserID', isEqualTo: user!.uid)
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
                            final price = doc.data()['price'];
                            // dynamic Linkimage = doc.data()['ImageUrls'] ?? '';
                            // final docID = doc.id;

                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                // color: Colors.white,
                                color: Colors.primaries[Random().nextInt(10)],
                                child: ListTile(
                                  title: Text('Title:  $productName',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22)),
                                  // Stack(
                                  //   children: [
                                  //     // Text('$productName '),
                                  //     Image(image: NetworkImage(Linkimage)),
                                  //     Positioned(
                                  //       top: 20,
                                  //       left: 20,
                                  //       child: Container(
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.black.withOpacity(0.7)),
                                  //         child: Padding(
                                  //           padding: EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //             '$productName ',
                                  //             style: TextStyle(color: Colors.white),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     // FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: snapshot.data)
                                  //   ],
                                  // ),
                                  subtitle: Text('Price:  $price',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        // Edit the product...
                                        onPressed: () {},
                                        icon: Icon(Icons.edit),
                                        color: Colors.white,
                                        iconSize: 29,
                                      ),
                                      IconButton(
                                        // Delete Product Pop-up function...
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  // title: Text(
                                                  //     'Are you sure to delete?'),
                                                  title: Text(
                                                      'Delete the Product?'),
                                                  content: Text(
                                                      'Do you want to delete this product permanently.'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Uploadproduct
                                                              .deleteProduct(
                                                                  doc.id);
                                                        },
                                                        child: Text('Yes')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('No')),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.white,
                                        iconSize: 29,
                                      ),
                                    ],
                                  ),

                                  // onTap Navigation is not required in seller page...
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SellerProductDetail(doc: doc))),
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
