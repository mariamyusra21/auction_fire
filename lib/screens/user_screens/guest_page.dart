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
  List<dynamic> productsList = [];
  Future getProductList() async {
    var data =
        await FirebaseFirestore.instance.collection('Updateproduct').get();

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
        title: Text('Action Fire'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: productsList[index] as Uploadproduct,
                onpress: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage())),
              );
            }),
      ),
    );
  }
}







// Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: db.collection('Users').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               var doc = snapshot.data.documents;
//               return new ListView.builder(
//                   itemCount: doc.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         child: Column(
//                           children: <Widget>[
//                             Text(doc[index].data['email']),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             Text(doc[index].data['phone']),
//                           ],
//                         ),
//                       ),
//                     );
//                   });
//             } else {
//               return LinearProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );