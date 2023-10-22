import 'package:auction_fire/screens/profile/viewprofile.dart';
import 'package:auction_fire/screens/user_screens/guest_page.dart';
import 'package:auction_fire/screens/user_screens/seller_pages/add_product_screen.dart';
import 'package:auction_fire/screens/user_screens/seller_pages/seller_products.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerHomeScreen extends StatefulWidget {
  final User? user;
  const SellerHomeScreen({super.key, this.user});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  // id used to access pages of app
  Widget selectedScreen = SellerHomeScreen();

  final FirebaseAuth auth = FirebaseAuth.instance;
  // User? user = FirebaseAuth.instance.currentUser;
  // late var uid = widget.user.uid;

  final String docID =
      FirebaseFirestore.instance.collection('Updateproduct').doc().id;

  // Exclude user's products stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getProductStream(String userId) {
    return FirebaseFirestore.instance
        .collection('Updateproduct')
        .where('UserID', isNotEqualTo: userId) // Exclude user's products
        .snapshots();
  }

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
      drawer: Drawer(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFD45A2D),
            Color(0xFFBD861C),
            Color.fromARGB(67, 0, 130, 181)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ListView(
            
            children: [
               DrawerHeader(
                child: 
                Column(
                  children: [
                    //profile retrieval image display in drawer 
                    GestureDetector(
                      onTap: () => const ProfileDetailScreen(),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: imageUrls==null 
                        ?  Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThlTauvFuw7q1xluWrxtf2uFBYgaa_a2GQfg&usqp=CAU').image
                      :NetworkImage(imageUrls) 
                      ),
                    ),
                    Text('$displayName')
                  ],
                )
                // Text('Seller Options',
                //     style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        
              ),
              ListTile(
                title: const Text(
                  'Add Product',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddProduct(), // Replace with your actual screen widget
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('My Products',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SellerProducts(), // Replace with your actual screen widget
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
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
                    stream:
                        //  getProductStream(widget.user!.uid),
                        FirebaseFirestore.instance
                            .collection('Updateproduct')
                            // where condition is used here so that seller can see other products except his own.
                            // .where('UserID' != user!.uid)
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

                            if (doc.data()['UserID'] == widget.user?.uid) {
                              Center(
                                  child: Text(
                                      'User\'s Products are not shown in dashboard'));
                            } else {
                              return ListTile(
                                title: Stack(
                                  children: [
                                    // Text('$productName '),
                                    Image(image: NetworkImage(Linkimage)),
                                    Positioned(
                                      top: 20,
                                      left: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            '$productName ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: snapshot.data)
                                  ],
                                ),
                                subtitle: Text('$detail'),
                                // onTap Navigation is not required in seller page...
                                // onTap: () => Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SellerProductDetail(doc: doc))),
                              );
                            }
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

  Widget MyDrawerList() {
    return Container();
  }

  // get profile image from firebase firestore to show in Avator in drawer

   dynamic imageUrls;
   String? displayName;
  @override
  void initState() {
    getProfileImage().then((url){
      setState(() {
        imageUrls= url;
      });
    });
    getDisplayName().then((name){
      setState(() {
        displayName= name;
      });
    });
    super.initState();
  }

  Future getProfileImage() async{
  final profileimage= FirebaseFirestore.instance;
  final doc = await profileimage.collection("Users").doc(widget.user?.uid).get();
  return doc.data()?["photoURL"];
  }

  Future getDisplayName() async{
  final profileimage= FirebaseFirestore.instance;
  final doc = await profileimage.collection("Users").doc(widget.user?.uid).get();
  return doc.data()?["displayName"];
  }
}
