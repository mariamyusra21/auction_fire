import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/user_main_func/bid.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Uploadproduct product;
  
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _Product_DetailState();
}


class _Product_DetailState extends State<ProductDetail> {

   
  @override
  Widget build(BuildContext context) {
    return 
    //Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Color(0xFFD45A2D),centerTitle: true,
      //   title: Text('${widget.product.productName} Details'),
      // ),
       Container(
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
                  'Product details: ${widget.product.detail}',
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                ),
               
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:GestureDetector(
                      child: Container(
                        
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                           border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
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
                              builder: (context) => BidPage(
                                product: widget.product,
                              ),
                            ),
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
   // );
  }
}
