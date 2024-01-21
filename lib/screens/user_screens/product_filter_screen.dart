import 'package:auction_fire/screens/user_screens/buyer_pages/buyer_product_detail_page.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    super.key,
    this.category,
    this.doc,
  });
  final String? category;
  final DocumentSnapshot? doc;

  @override
  State<ProductScreen> createState() => _ProductScreenStateState();
}

class _ProductScreenStateState extends State<ProductScreen> {
  TextEditingController searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text("${widget.category}"),
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
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //  stream:  FirebaseFirestore.instance.collection('Updateproduct').snapshots(),
                stream: FirebaseFirestore.instance
                    .collection('Updateproduct')
                    .where("category", isEqualTo: widget.category)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data == null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                              "Ooops! No ${widget.category} Products available")),
                    );
                  } else {
                    final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        docs = snapshot.data!.docs;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (_, index) {
                          final doc = docs[index];
                          final productName = doc.data()["productName"];
                          // final   detail = doc.data()['detail'];
                          final Linkimage = doc.data()['ImageUrls'] ?? '';
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
                            //  subtitle: Text('$detail'),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> searchedItem = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions

    //TO return clear query
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('Updateproduct').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('loading...');

        final results =
            snapshot.data?.docs.where((a) => a['productName'].contains(query));

        return ListView(
          children: results!
              .map<Widget>((a) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BuyerProductDetail(doc: a))),
                          child: Text(a['productName'])),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('Updateproduct').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('loading...');

        final results =
            snapshot.data?.docs.where((a) => a['productName'].contains(query));

        return ListView(
          children: results!
              .map<Widget>((a) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BuyerProductDetail(doc: a))),
                        child: Text(a['productName'])),
                  ))
              .toList(),
        );
      },
    );
  }
}
