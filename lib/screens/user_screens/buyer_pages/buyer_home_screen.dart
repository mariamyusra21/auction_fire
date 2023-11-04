import 'package:auction_fire/screens/user_screens/buyer_pages/buyer_product_detail_page.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/guest_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  // id used to access pages of app
  Widget selectedScreen = BuyerHomeScreen();

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final String docID =
      FirebaseFirestore.instance.collection('Updateproduct').doc().id;

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GuestPage()));
  }

  final List imageCarouseSlider = [
    "https://cdn.pixabay.com/photo/2016/11/19/11/33/footwear-1838767_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/27/04/32/books-1163695_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/19/11/33/footwear-1838767_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/27/04/32/books-1163695_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_1280.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // drawer: Drawer(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     decoration: BoxDecoration(
      //         gradient: LinearGradient(colors: [
      //       Color(0xFFD45A2D),
      //       Color(0xFFBD861C),
      //       Color.fromARGB(67, 0, 130, 181)
      //     ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      //     child: ListView(
      //       children: [
      //         const DrawerHeader(
      //           child: Text('Drawer Header'),
      //         ),
      //         ListTile(
      //           title: const Text('Add Product'),
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) =>
      //                     AddProduct(), // Replace with your actual screen widget
      //               ),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)), this is like a drawer in appbar
        actions: <Widget>[
          //notice bell button
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          //profile button
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline_sharp,
                size: 30,
              ),
              alignment: Alignment.bottomRight,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
              alignment: Alignment.bottomCenter,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              alignment: Alignment.bottomLeft,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFD45A2D),
              Color(0xFFBD861C),
              Color.fromARGB(67, 0, 130, 181)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(
              children: [
                CarouselSlider(
                  items: imageCarouseSlider
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
                                    borderRadius: BorderRadius.circular(20),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Title',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(height: 220, autoPlay: true),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Updateproduct')
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            docs = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (_, index) {
                            final doc = docs[index];
                            final productName = doc.data()["productName"];
                            final detail = doc.data()['detail'];
                            dynamic Linkimage = doc.data()['ImageUrls'] ?? '';
                            // final docID = doc.id;

                            return         ListTile(
                              title: Stack(
                                children: [
                                  // Text('$productName '),
                                  Image(image: NetworkImage(Linkimage)),
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          '$productName ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: snapshot.data)
                                ],
                              ),
                              subtitle: Text('$detail'),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BuyerProductDetail(doc: doc))),
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
      ),
    );
  }

  // Widget MyDrawerList() {
  //   return Container();
  // }
}
