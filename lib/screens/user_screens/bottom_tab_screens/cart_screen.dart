import 'package:auction_fire/screens/payment_systems/payment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  CollectionReference db = FirebaseFirestore.instance.collection('Cart');

  DeleteCart(String id, BuildContext context) {
    db.doc(id).delete().then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(
            SnackBar(content: Text("Cart Item Successfuly Deleted"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFD45A2D),
          title: Text(
            'Cart Items',
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
                  stream:
                      FirebaseFirestore.instance.collection('Cart').snapshots(),
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
                    } // if
                    return Container(
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext build, int index) {
                            final res = snapshot.data!.docs[index];
                            final price = res['price'] * 100;
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Card(
                                  elevation: 10.0,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        res['image'],
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${res['ProductName']}",
                                              style: TextStyle(fontSize: 20.0),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          DeleteCart(res.id, context);
                                        },
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentView(
                                                      price: price.toString(),
                                                    ))),
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.blue,
                                          child: Icon(
                                            Icons.payment,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    );
                  }),
            ),
          ),
        ));
  }
}
