import 'package:auction_fire/screens/user_screens/user_main_func/add_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/add_product_model.dart';
import '../../widgets/product_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // id used to access pages of app
  Widget selectedScreen = HomeScreen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
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
        //  child: SingleChildScrollView(
        //   child: Container(
        //     child: Column(
        //       children: [
        //         const DrawerHeader(child: Text('WELCOME')),
        //         MyDrawerList(),
        //       ],
        //     ),
        //   ),
        //  ),
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
            onPressed: () {},
            icon: Icon(Icons.circle_outlined),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Padding(padding: EdgeInsets.all(5)),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline_sharp,
                size: 30,
              ),
              alignment: Alignment.bottomRight,
            ),
            Padding(padding: EdgeInsets.only(right: 105)),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
              alignment: Alignment.bottomCenter,
            ),
            Padding(padding: EdgeInsets.only(left: 105)),
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
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: productsList[index] as Uploadproduct,
                onpress: () {},
              );
            }),
      ),
    );
  }

  List<dynamic> productsList = [];
  Future getProductList() async {
    var data =
        await FirebaseFirestore.instance.collection('Updateproduct').get();

    setState(() {
      productsList =
          List.from(data.docs.map((doc) => Uploadproduct.fromSnapshot(doc)));
    });
  }
}
