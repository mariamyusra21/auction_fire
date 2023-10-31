import 'dart:math';

import 'package:auction_fire/screens/user_screens/login_page.dart';
import 'package:auction_fire/screens/user_screens/product_filter_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auction_fire/screens/user_screens/seller_pages/add_product_screen.dart';
import 'package:sizer/sizer.dart';
import '../../models/add_product_model.dart';
import '../../widgets/product_cards.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  User? user = FirebaseAuth.instance.currentUser;
  List<dynamic> productsList = [];
  Future getProductList() async {
    var data = await FirebaseFirestore.instance
        .collection('Updateproduct')
        // .where('UserID', isEqualTo: user!.uid)
        .get();
    setState(() {
      productsList =
          List.from(data.docs.map((doc) => Uploadproduct.fromSnapshot(doc)));
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getProductList();
  // }
    final List imageCarouseSlider= [
    "https://cdn.pixabay.com/photo/2016/11/19/11/33/footwear-1838767_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/27/04/32/books-1163695_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/19/11/33/footwear-1838767_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/27/04/32/books-1163695_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_1280.jpg"
    ];

     List categories = [
    "Garments",
    "Electronics",
    "Jewllery",
    "Foot_Wear",
    "Cosmatics",
    "Stationary"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'Welcome to AUCTION FIRE',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFD45A2D),
                Color(0xFFBD861C),
                Color.fromARGB(67, 0, 130, 181)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              
              // ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     itemCount: productsList.length,
              //     itemBuilder: (context, index) {
              //       return Column(
                      
              //         // mainAxisSize: MainAxisSize.min,
              //         children: [
              //           Container(
              //             width: MediaQuery.of(context).size.width,
              //             child: GestureDetector(
                            
              //               onTap: () => Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => LoginPage())),
              //               child: ProductCard(
              //                 product: productsList[index] as Uploadproduct,
              //                 // productId: '',
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //         ],
              //       );
              //     }),
              child: Column(   
                children: [
                 const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Text("Categories", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  ),
                  Row( 
                    // displaying categories in row 
                    // then using product filter screen to show categroies wise products
                    children: [
                    
                      ...List.generate(categories.length, (index) => Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=>  ProductScreen()));
                          },
                          child: Container(
                            height: 5.h, width: 18.w,
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              child: Center(
                                child: Padding(padding: const EdgeInsets.all(8),
                                child: Text(
                                  categories[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                                ),
                              ),
                              decoration:  BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 3,
                                    spreadRadius: 2
                                  )
                                ],
                                color: Colors.primaries[
                                  Random().nextInt(categories.length)
                                ]
                              ),
                            ),
                          ),
                        ),
                      )),
                      
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    
                    stream:  FirebaseFirestore.instance.collection('Updateproduct').snapshots(),
                     builder:  (BuildContext context, snapshot) {
                        if (snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                    } else {
                        final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!.docs;
                          
                        return ListView.builder(
                              itemCount: docs.length,
                        itemBuilder: (_, index) {
                              final doc = docs[index];
                              final productName = doc.data()["productName"];
                              final   detail = doc.data()['detail'];
                              final Linkimage= doc.data()['ImageUrls'] ?? '';
                              //final Linkimage = doc.data()['imageUrl'];
                        // final docID = doc.id;
                       
                               return ListTile(
                     title: Column(
                       children: [
                    Text('$productName '),
                    Image(image: NetworkImage(Linkimage))
                            // FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: Linkimage )
                       ],
                     ),
                               subtitle: Text('$detail'),
                    onTap: () => Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => LoginPage())),
                      );
                    },
                              );
                               }
                              },
                     ),
                  ),
                ],
              ),                   
            ),
      ),
    );
  }
}
