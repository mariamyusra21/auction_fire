import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/user_main_func/bid.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.productName} Details'),
      ),
      body: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BidPage(
                  product: widget.product,
                ),
              ),
            );
          },
          child: Text('Place bid')),
    );
  }
}
