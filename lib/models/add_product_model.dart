import 'package:cloud_firestore/cloud_firestore.dart';

class Uploadproduct {
  String? category;
  String? id;
  String? uid;
  String? productName;
  String? detail;
  int? price;
  int? discountPrice;
  double? currentHighestBid;
  String? serialNo;
  List<String>? imageUrls;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavorite;

  Uploadproduct(
      {required this.category,
      required this.id,
      required this.uid,
      required this.productName,
      required this.detail,
      required this.price,
      required this.discountPrice,
      required this.currentHighestBid,
      required this.serialNo,
      required this.imageUrls,
      required this.isOnSale,
      required this.isPopular,
      required this.isFavorite});

  static Future<void> addProduct(Uploadproduct addproduct) async {
    //function to add data in firestore database
    //to point out collections we use collectionreference
    // var user = FirebaseAuth.instance.currentUser;
    CollectionReference db = FirebaseFirestore.instance
        // .collection('Users')
        // .doc(user!.uid)
        .collection('Updateproduct'); //<= OBJECT
    // String docId = db.doc().id;
    Map<String, dynamic> data = {
      // 'id': docId,
      "category": addproduct.category,
      "productName": addproduct.productName,
      "detail": addproduct.detail,
      "price": addproduct.price,
      "discountPrice": addproduct.discountPrice,
      "serial Code": addproduct.serialNo,
      "ImageUrls": addproduct.imageUrls,
      'UserID': addproduct.uid,
      'currentHighestBid': addproduct.currentHighestBid,
      "isOnSale": addproduct.isOnSale,
      "isPopular": addproduct.isPopular,
      "isFavorite": addproduct.isFavorite,
    };
    // await db.add(data);
    await db.add(data).then((DocumentReference doc) {
      print("Document ID is: ${doc.id}");
      db.doc(doc.id).update({'id': doc.id});
    });
  }

  Uploadproduct.fromSnapshot(snapshot)
      : category = snapshot.data()["category"],
        id = snapshot.data()['id'],
        productName = snapshot.data()["productName"],
        detail = snapshot.data()["detail"],
        price = snapshot.data()["price"],
        uid = snapshot.data()['UserID'],
        discountPrice = snapshot.data()["discountPrice"],
        serialNo = snapshot.data()["serial Code"],
        currentHighestBid = snapshot.data()['currentHighestBid'],
        // imageUrls = snapshot.data()["ImageUrls"],
        isOnSale = snapshot.data()["isOnSale"],
        isPopular = snapshot.data()["isPopular"],
        isFavorite = snapshot.data()["isFavorite"];
}
