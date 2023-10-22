import 'dart:io';

import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/buyer_pages/bid.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
          
        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: widget.product?.detailimageUrls?.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return ListTile(
        //         contentPadding: EdgeInsets.all(8.0),
              
        //         leading: Image.network(
        //            widget.product?.detailimageUrls?[index],  
        //             fit: BoxFit.fill),
        //       );
        //     }),     

            //       ListView.builder(
            //      itemCount: widget.product?.detailimageUrls?.length,
            //       itemBuilder: (context, index) {
            //   // Use widget.detailimageUrls[index] to load and display each image
            //  return Image.network(widget.product!.detailimageUrls![index]);}), 
            
                  //  ...List.generate(
                  //    widget.doc.get('detailimageUrls').length, 
                  //  // widget.doc['detailimageUrls'].length,
                  //    (index) => 
                  //     Stack(
                  //     children: [
                  //       Image.network(
                  //         widget.doc.get('detailimageUrls'), 
                  //         height: 400.h, width: 400.w, fit: BoxFit.contain,),
                           
                  //     ],
                  //   )).toList(),  
                     StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                       stream: FirebaseFirestore.instance
                           .collection('Updateproduct')
                           .snapshots(),
                       builder: (BuildContext context, snapshot) {
                         // print(snapshot.data);
                         if (snapshot.data == null) {
                           return Center(child: CircularProgressIndicator());
                         } else {
                           final List<DocumentSnapshot<Map<String, dynamic>>>
                               docs = snapshot.data!.docs;
                              //  docs.forEach((element) {
                              //    print(element.data());
                               
                              //  });  
                               
                               
                                 return Expanded(
                                   child: ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index){
                                  
                                      final doc = docs[index];
                                       List Linkimage = doc.data()?['detailimageUrls'] ?? '';
                                       print(Linkimage);
                                    
                                        //var imageUrlList = docs[index].data()["detailimageUrls"];
                              //      docs.forEach((element) {
                              //    print(element.data()?["detailimageUrls"]);
                              // Stack
                              // (children: [Image.network(element.data()!["detailimageUrls"])]);
                              //  });  
                                 List<String> imageUrls = List<String>.from(doc.data()?['detailimageUrls']);

        return Column(
          children: imageUrls.map((url) {
            return Image.network(url); // Display each image in a Column.
          }).toList(),
        );
                                     
                                     // return Image.network(imag);
                                      
                                    }
                                    ),
                                 );
                               
                          
                    //        return Column(
                    //          children: [
                    //    ...List.generate(
                    //     widget.product!.detailimageUrls!.length, (index) => 
                    // Stack(
                    //   children: [
                    //     Image.network(
                    //       widget.product!.detailimageUrls![index], 
                    //       height: 15.h, width: 15.w, fit: BoxFit.contain,),
                    //         ],
                    //                 ),
                    //                  ) 
                    //          ]
                    //                );
                         } }
                      ),
  
           
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
      
    );
  }
  
}
