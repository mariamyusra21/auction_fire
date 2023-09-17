import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/guest_page.dart';
import 'package:auction_fire/screens/user_screens/user_main_func/add_product_screen.dart';
import 'package:auction_fire/screens/user_screens/user_main_func/product_detail_page.dart';
import 'package:auction_fire/widgets/product_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // id used to access pages of app
  Widget selectedScreen = HomeScreen();

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  List<dynamic> productsList = [];
  Future getProductList() async {
    var data = await FirebaseFirestore.instance
        .collection('Updateproduct')
        .where('UserID', isEqualTo: user!.uid)
        .get();

    setState(() {
      productsList =
          List.from(data.docs.map((doc) => Uploadproduct.fromSnapshot(doc)));
    });
    // final String docID =
    //     FirebaseFirestore.instance.collection('Updateproduct').doc().id;
  }

  final String docID =
      FirebaseFirestore.instance.collection('Updateproduct').doc().id;

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GuestPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getProductList();
  }

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
              const DrawerHeader(
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Add Product'),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFD45A2D),
          Color(0xFFBD861C),
          Color.fromARGB(67, 0, 130, 181)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(
                                product: productsList[index] as Uploadproduct,
                              )));
                },
                child: ProductCard(
                  product: productsList[index] as Uploadproduct,
                  // productId: docID,
                ),
              );
            }),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container();
  }
}
