import 'package:auction_fire/models/add_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // CollectionReference referenceProduct = FirebaseFirestore.instance;
  // .collection('Users')'
  // .doc()
  // .collection('Updateproduct');

  List<dynamic> productsList = [];
  Future getProductList() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    var data = await FirebaseFirestore.instance
        // .collection('Users')
        // .doc()
        // .doc(uid.toString())
        .collection('Updateproduct')
        // .orderBy(uid!)
        .get();

    setState(() {
      productsList =
          List.from(data.docs.map((doc) => Uploadproduct.fromSnapshot(doc)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Lists'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            return ProductListTile(
                product: productsList[index] as Uploadproduct);
          }),
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
