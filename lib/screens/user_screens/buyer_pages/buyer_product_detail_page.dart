import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/buyer_pages/bid.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class BuyerProductDetail extends StatefulWidget {
  final DocumentSnapshot doc;
  Uploadproduct? product;
   BuyerProductDetail({
    Key? key,
    required this.doc,
    this.product
  }) : super(key: key); 

  @override
  State<BuyerProductDetail> createState() => _BuyerProductDetailState();
}

class _BuyerProductDetailState extends State<BuyerProductDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              //       ListView.builder(
              //      itemCount: widget.product?.detailimageUrls?.length,
              //       itemBuilder: (context, index) {
              //   // Use widget.detailimageUrls[index] to load and display each image
              //  return Image.network(widget.product!.detailimageUrls![index]);}), 
                    //  ...List.generate(widget.product!.detailimageUrls!.length, (index) => 
                    //     Stack(
                    //     children: [
                    //       Image.network(
                    //         widget.product!.detailimageUrls![index], 
                    //         height: 400.h, width: 400.w, fit: BoxFit.contain,),
                             
                    //     ],
                    //   )).toList(),  
                  //     CarouselSlider(
                  //   items: widget.product!.detailimageUrls!
                  //       .map(
                  //         (e) => Stack(
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(20),
                  //                   child: Image.network(
                  //                     e,
                  //                     fit: BoxFit.cover,
                  //                     width: double.infinity,
                  //                     height: 200,
                  //                   )),
                  //             ),
                  //             //using colors as above the pictures to blur them or in starting view just show color when the app will loading
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Container(
                  //                 height: 200,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(20),
                  //                     gradient: LinearGradient(colors: [
                  //                       Colors.redAccent.withOpacity(0.3),
                  //                       Colors.blueAccent.withOpacity(0.3)
                  //                     ])),
                  //               ),
                  //             ),
                  //             // container of title of the product
                  //             Positioned(
                  //               bottom: 20,
                  //               left: 20,
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.black.withOpacity(0.5)),
                  //                 child: Padding(
                  //                   padding: EdgeInsets.all(8.0),
                  //                   child: Text(
                  //                     "Price: ${widget.doc['price']}"
                  //                     // style: TextStyle(
                  //                     //     fontSize: 20, color: Colors.white
                  //                         //),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //       .toList(),
                  //  options: CarouselOptions(height: 220, autoPlay: true),
                  // ),
                 
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
      ),
    );
  }
}
