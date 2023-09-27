import 'package:auction_fire/screens/user_screens/buyer_pages/bid.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerProductDetail extends StatefulWidget {
  final DocumentSnapshot doc;
  const BuyerProductDetail({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<BuyerProductDetail> createState() => _BuyerProductDetailState();
}

class _BuyerProductDetailState extends State<BuyerProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        centerTitle: true,
        title: Text('${widget.doc['productName']} Details'),
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
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Product details: ${widget.doc['detail']}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyerBidPage(
                                      documentSnapshot: widget.doc)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
