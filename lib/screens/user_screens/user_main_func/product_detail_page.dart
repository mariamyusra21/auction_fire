import 'package:auction_fire/screens/user_screens/user_main_func/bid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _Product_DetailState();
}

class _Product_DetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: ElevatedButton(onPressed: (){
       Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BidPage(), 
                    ),
                  );
      }, child: Text('Place bid')),
    );
  }
}