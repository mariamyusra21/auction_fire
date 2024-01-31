import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/admin_screens/product_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference referenceUsers =
      FirebaseFirestore.instance.collection('Updateproduct');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Products Lists'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Updateproduct')
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                  snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    final doc = docs[index];

                    final productName = doc.data()['productName'];
                    // return UserListTile(userData: doc.data());
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetails(detailSnapshot: doc)));
                        },
                        child: Card(
                          elevation: 10.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // leading: Image.network(
                              //   profileImage,
                              //   height: 90,
                              //   width: 70,
                              //   fit: BoxFit.fill,
                              // ),
                              title: Text('$productName'),
                              subtitle: Column(
                                children: [
                                  Text(
                                      'Brand Name: ${doc.data()['brandName']}'),
                                  Text('Price: ${doc.data()['price']}'),
                                  Text(
                                      'Highest Bid: ${doc.data()['currentHighestBid']}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //     onPressed: () {}, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                // title: Text(
                                                //     'Are you sure to delete?'),
                                                title:
                                                    Text('Delete the Product?'),
                                                content: Text(
                                                    'Do you want to delete product ${productName} permanently.'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Uploadproduct
                                                            .deleteProduct(
                                                                doc.id);
                                                      },
                                                      child: Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No')),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),

      // ListView.builder(
      //     itemCount: productsList.length,
      //     itemBuilder: (context, index) {
      //       return ProductListTile(
      //           product: productsList[index] as Uploadproduct);
      //     }),
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product});
  final Uploadproduct product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${product.productName}'),
      subtitle: Column(
        children: [
          Text('description: ${product.detail}'),
          // Text('${product.imageUrls}'),
          Text('price: ${product.price}'),
          Text('discount: ${product.discountPrice}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('serial No: ${product.serialNo}'),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
