import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SellerProductDetail extends StatefulWidget {
  final DocumentSnapshot doc;

  const SellerProductDetail({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  State<SellerProductDetail> createState() => _Product_DetailState();
}

class _Product_DetailState extends State<SellerProductDetail> {
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
                  // Stream builder to display detail images of product using document from homescreen...
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Updateproduct')
                        .doc(widget.doc.id)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        // Assuming 'detailImageUrls' is the field in Firestore where you store the image URLs.
                        List<String> imageUrls = List<String>.from(
                            snapshot.data?['detailimageUrls']);

                        // Slider of products...

                        return CarouselSlider(
                          items: imageUrls
                              .map(
                                (e) => Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            e,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 200,
                                          )),
                                    ),
                                    //using colors as above the pictures to blur them or in starting view just show color when the app will loading
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(colors: [
                                              Colors.redAccent.withOpacity(0.3),
                                              Colors.blueAccent.withOpacity(0.3)
                                            ])),
                                      ),
                                    ),
                                    // container of title of the product
                                    Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              "Price: ${widget.doc['price']}"
                                              // style: TextStyle(
                                              //     fontSize: 20, color: Colors.white
                                              //),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(height: 220, autoPlay: true),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Product Details: ${widget.doc['detail']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Current Highest Bid: ${widget.doc['currentHighestBid']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Price: ${widget.doc['price']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Discount Price: ${widget.doc['discountPrice']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Serial Code: ${widget.doc['serial Code']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: GestureDetector(
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       width: 200,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               color: Colors.black,
                  //               style: BorderStyle.solid,
                  //               width: 2),
                  //           borderRadius: BorderRadius.circular(50),
                  //           gradient: const LinearGradient(colors: [
                  //             Color(0xFFD45A2D),
                  //             Color(0xFFBD861C),
                  //             Color.fromARGB(67, 0, 130, 181)
                  //           ])),
                  //       child: BidButton(
                  //         buttonTitle: "Place bid",
                  //         onPress: () async {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => BidPage(
                  //                 product: widget.product,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
