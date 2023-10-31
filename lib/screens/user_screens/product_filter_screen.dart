import 'package:auction_fire/models/add_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
   ProductScreen({super.key, this.category});
  String? category;


  @override
  State<ProductScreen> createState() => _ProductScreenStateState();
}

class _ProductScreenStateState extends State<ProductScreen> {

    List<Uploadproduct> allProducts = [];

  getDate() async {
    await FirebaseFirestore.instance
        .collection("Updateproducts")
        .get()
        .then((QuerySnapshot? snapshot) {
      if (widget.category == null) {
        snapshot!.docs.forEach((e) {
          if (e.exists) {
            setState(() {
              allProducts.add(
                Uploadproduct(
                  // id: e["id"],
                  productName: e["productName"],
                  imageUrls: e["imageUrls"],
                ),
              );
            });
          } print("${e} ok" );
        });
      }
      //  else {
      //   snapshot!.docs
      //       .where((element) => element["category"] == widget.category)
      //       .forEach((e) {
      //     if (e.exists) {
      //       setState(() {
      //         allProducts.add(
      //           Products(
      //             id: e["id"],
      //             productName: e["productName"],
      //             imageUrls: e["imageUrls"],
      //           ),
      //         );
      //       });
      //     }
      //   });
      // }
    });
    // print(allProducts[0].discountPrice);
  }

  // List<Updateproducts> totalItems = [];

  // @override
  // void initState() {
  //   getDate();
  //   Future.delayed(Duration(seconds: 1), () {
  //     totalItems.addAll(allProducts);
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
          itemCount: allProducts.length, 
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Column(
              children: [
                Image.network(allProducts[index].imageUrls.last, 
                height: 100,
                width: 100,
                fit: BoxFit.cover,),
                Text(allProducts[index].productName!)
              ],
            ),
          );
        }
        ),
    );
  }
}