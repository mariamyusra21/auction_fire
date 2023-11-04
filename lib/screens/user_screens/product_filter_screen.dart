import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_screens/user_creation_welcome_screen/login_page.dart';
import 'package:auction_fire/widgets/bidtextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  List<Uploadproduct> allProducts = [];
  TextEditingController searchC = TextEditingController();
  List<Uploadproduct> searchedItems = [];

  @override
  void initState() {
    searchedItems.addAll(allProducts);
    // TODO: implement initState
    // getProductCategory();
    super.initState();
  }

  filterproduct(String query) {
    List<Uploadproduct> dumysearch =
        []; // jub search ho rha ho to show karwata jaye
    dumysearch.addAll(allProducts); //dumysearch add karwata jaye items me
    if (query.isNotEmpty) {
      List<Uploadproduct> dumydata =
          []; // foreach ke way se one by one relate karke show data karega
      dumysearch.forEach((element) {
        if (element.productName!
            .toLowerCase() //condition to show result in lower case eother user search in upper or lower
            .contains(query.toLowerCase())) {
          dumydata.add(element);
        }
      });
      setState(() {
        allProducts.clear();
        allProducts.addAll(searchedItems);
        print(" okk ${searchedItems}");
      });
      return;
    } else {
      setState(() {
        allProducts.clear();
        allProducts.addAll(searchedItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text("${widget.category}"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearch());
              },
              icon: Icon(Icons.search))
        ],
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
              // TextFormField(
              //   controller: searchC,
              //   onChanged: (v) {
              //     filterproduct(searchC.text);
              //   },
              //   decoration: InputDecoration(
              //     hintText: "Search item...",
              //     icon: Icon(Icons.search),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
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
  List<Uploadproduct> searchedItem = [];

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
    // TODO: implement buildResults
    List<Uploadproduct> matchQuery = [];
    for (var element in searchedItem) {
      if (element.productName!.contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result.toString()),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Uploadproduct> matchQuery = [];
    for (var element in searchedItem) {
      if (element.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result as String),
          );
        });
  }
}
