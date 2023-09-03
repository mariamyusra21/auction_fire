import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Uploadproduct {
  String? category;
  String? id;
  String? productName;
  String? detail;
  int? price;
  int? discountPrice;
  String? serialNo;
  List<String>? imageUrls;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavorite;

  Uploadproduct(
      {required this.category,
      required this.id,
      required this.productName,
      required this.detail,
      required this.price,
      required this.discountPrice,
      required this.serialNo,
      required this.imageUrls,
      required this.isOnSale,
      required this.isPopular,
      required this.isFavorite});

  static Future<void> addProduct(Uploadproduct addproduct) async {
    //function to add data in firestore database
    //to point out collections we use collectionreference
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference db = FirebaseFirestore.instance
        // .collection('Users')
        // .doc(user!.uid)
        .collection('Updateproduct'); //<= OBJECT
    Map<String, dynamic> data = {
      "category": addproduct.category,
      "productName": addproduct.productName,
      "detail": addproduct.detail,
      "price": addproduct.price,
      "discountPrice": addproduct.discountPrice,
      "serial Code": addproduct.serialNo,
      "ImageUrls": addproduct.imageUrls,
      "isOnSale": addproduct.isOnSale,
      "isPopular": addproduct.isPopular,
      "isFavorite": addproduct.isFavorite,
    };
    await db.add(data);
  }

  Uploadproduct.fromSnapshot(snapshot)
      : category = snapshot.data()["category"],
        productName = snapshot.data()["productName"],
        detail = snapshot.data()["detail"],
        price = snapshot.data()["price"],
        discountPrice = snapshot.data()["discountPrice"],
        serialNo = snapshot.data()["serial Code"],
        // imageUrls = snapshot.data()["ImageUrls"],
        isOnSale = snapshot.data()["isOnSale"],
        isPopular = snapshot.data()["isPopular"],
        isFavorite = snapshot.data()["isFavorite"];
}
