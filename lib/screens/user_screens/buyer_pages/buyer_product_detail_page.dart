import 'package:auction_fire/screens/user_screens/buyer_pages/bid.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyerProductDetail extends StatefulWidget {
  final DocumentSnapshot doc;
  BuyerProductDetail({
    Key? key,
    required this.doc,
  });

  @override
  State<BuyerProductDetail> createState() => _BuyerProductDetailState();
}

class _BuyerProductDetailState extends State<BuyerProductDetail> {
  bool isfav = false;

  addToFavProduct() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    // all users have there own fav items
    // that is why there another subcollection items present in fav database
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({
      'prodId': widget.doc.id,
    });
  }

  RemoveFromFavProduct(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("favorite");
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        centerTitle: true,
        title: Text('${widget.doc['productName']} Details'),
        actions: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("favorite")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  //herre we use where to filter that if the field is added or not
                  .collection("items")
                  .where('prodId', isEqualTo: widget.doc.id)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  // if data is not present
                  return Text(" there is nothing favorite");
                }
                return IconButton(
                  onPressed: () {
                    snapshot.data!.docs.length == 0 
                    ? addToFavProduct() 
                    : RemoveFromFavProduct(snapshot.data!.docs.first.id);
                    // if the id's we stored and the current product is not matched
                    // then add the prod to fav
                    // setState(() {
                      
                    //   if (!isfav) {
                    //     isfav = true;
                    //   } else {
                    //     isfav = false;
                    //   }
                    // });
                  },
                  icon:  snapshot.data!.docs.length == 0 
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite),
                  color:  snapshot.data!.docs.length == 0  ? Colors.black : Colors.black,
                );
              })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFD45A2D),
          Color(0xFFBD861C),
          Color.fromARGB(67, 0, 130, 181)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                // Stream builder to display detail images of product using document from homescreen...
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Updateproduct')
                      .doc(widget.doc.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      // Assuming 'detailImageUrls' is the field in Firestore where you store the image URLs.
                      List<String> imageUrls =
                          List<String>.from(snapshot.data?['detailimageUrls']);

                      // Slider of products...

                      return CarouselSlider(
                        items: imageUrls
                            .map(
                              (e) => Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          e,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        )),
                                  ),
                                  //using colors as above the pictures to blur them or in starting view just show color when the app will loading
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(colors: [
                                            Colors.redAccent.withOpacity(0.3),
                                            Colors.blueAccent.withOpacity(0.3)
                                          ])),
                                    ),
                                  ),
                                  // container of title of the product
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            "Price: ${widget.doc['price']}"
                                            // style: TextStyle(
                                            //     fontSize: 20, color: Colors.white
                                            //),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(height: 220, autoPlay: true),
                      );
                    }
                  },
                ),

                // product details using document and bid button....
                SizedBox(
                  height: 250,
                ),
                Text(
                  'Product details: ${widget.doc['detail']}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(colors: [
                            Color(0xFFD45A2D),
                            Color(0xFFBD861C),
                            Color.fromARGB(67, 0, 130, 181)
                          ])),
                      child: BidButton(
                        buttonTitle: "Place bid",
                        onPress: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BuyerBidPage(documentSnapshot: widget.doc)),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
