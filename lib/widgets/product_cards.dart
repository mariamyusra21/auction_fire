import 'package:flutter/material.dart';

import '../models/add_product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    // required this.productId,
  });
  final Uploadproduct product;
  // final String productId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 2),
            gradient: LinearGradient(colors: [
              Color(0xFFD45A2D),
              Color(0xFFBD861C),
              Color.fromARGB(67, 0, 130, 181)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        height: 120,
        width: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   child: Image.network(
              //     product.imageUrls as String,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Text(
                'Product Name: ${product.productName}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              // Text(
              //   // 'Product ID: ${productId}',
              //   'Product ID: ${product.id}',

              //   style:
              //       TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              // ),
              // Text(
              //   // 'Product ID: ${productId}',
              //   'Product ID: ${product.uid}',

              //   style:
              //       TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              // ),
              Text(
                'Price: ${product.price}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Text(
                'Highest Bid: ${product.currentHighestBid}',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
