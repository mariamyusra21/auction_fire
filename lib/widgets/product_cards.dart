import 'package:flutter/material.dart';

import '../models/add_product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onpress});
  final Uploadproduct product;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onpress,
      child: Card(
        margin: EdgeInsets.all(15),
        child: Container(
          height: 170,
          width: 100,
          child: Column(
            children: [
              Icon(Icons.shopping_cart),
              Text(
                'price: ${product.price}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                'Product Name: ${product.productName}',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'Product Description: ${product.detail}',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
