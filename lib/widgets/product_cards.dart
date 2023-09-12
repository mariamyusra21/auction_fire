import 'package:flutter/material.dart';

import '../models/add_product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final Uploadproduct product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 2),
            gradient: LinearGradient(colors: [
              Color(0xFFD45A2D),
              Color(0xFFBD861C),
              Color.fromARGB(67, 0, 130, 181)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        height: 170,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 40,
            ),
            Text(
              'Product Name: ${product.productName}',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              'Product Description: ${product.detail}',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              'price: ${product.price}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
