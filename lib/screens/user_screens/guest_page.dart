import 'package:auction_fire/screens/user_screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/add_product_model.dart';
import '../../widgets/product_cards.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  // User? user = FirebaseAuth.instance.currentUser;
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
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'Action Fire Welcome Page',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
            shrinkWrap: true,
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return Column(
                
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage())),
                      child: ProductCard(
                        product: productsList[index] as Uploadproduct,
                        // productId: '',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
