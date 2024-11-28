import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductDetails extends StatefulWidget {
  final DocumentSnapshot detailSnapshot;
  const ProductDetails({super.key, required this.detailSnapshot});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${widget.detailSnapshot.get('productName')} Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              Text('Product Name: ${widget.detailSnapshot['productName']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Details: ${widget.detailSnapshot['detail']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Category: ${widget.detailSnapshot['category']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Brand Name: ${widget.detailSnapshot['brandName']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Price: ${widget.detailSnapshot['price']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Discount: ${widget.detailSnapshot['discountPrice']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text(
                  'Current Highest Bid: ${widget.detailSnapshot['currentHighestBid']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Seller ID: ${widget.detailSnapshot['UserID']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Product ID: ${widget.detailSnapshot['id']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Serial Code: ${widget.detailSnapshot['serial Code']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              BidButton(
                isLoginButton: true,
                color: Colors.black,
                onPress: () {
                  Navigator.pop(context);
                },
                buttonTitle: 'Back',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
