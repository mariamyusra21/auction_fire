import 'package:auction_fire/screens/user_screens/buyer_pages/buyer_product_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  //to get ids of user to show their favorites in fav screen
  List ids = [];

  getIds() async {
    FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          ids.add(element['prodId']);
          print(ids);
        });
      });
    });
  }

  @override
  void initState() {
    getIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFD45A2D),
          title: Text(
            'My Favorites',
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
            child: Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Updateproduct')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularStepProgressIndicator(
                          totalSteps: 12,
                          currentStep: 6,
                          selectedColor: Colors.redAccent,
                          unselectedColor: Colors.grey[200],
                          selectedStepSize: 10.0,
                          width: 100,
                          height: 100,
                          gradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.cyan, Colors.orangeAccent],
                          ),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Text('No Favourite Items found'),
                        );
                      }
                      List<QueryDocumentSnapshot<Object?>> favPro = snapshot
                          .data!.docs
                          .where((element) => ids.contains(element['id']))
                          .toList();
                      return ListView.builder(
                          itemCount: favPro.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(favPro[index]['productName']),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BuyerProductDetail(
                                                          doc: favPro[index])));
                                        },
                                        icon:
                                            Icon(Icons.navigate_next_rounded)),
                                  ),
                                ),
                              ),
                            );
                          });
                    })),
          ),
        ));
  }
}
