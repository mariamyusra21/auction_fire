import 'package:cloud_firestore/cloud_firestore.dart';

class Uploadproduct {
  String? category;
  String? id;
  String? uid;
  String? productName;
  String? proBrand;
  String? detail;
  int? price;
  int? discountPrice;
  int? currentHighestBid;
  String? serialNo;
 dynamic imageUrls;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavorite;
  List<dynamic>? detailimageUrls;

  Uploadproduct(
      { this.category,
       this.id,
       this.uid,
       this.productName,
       this.proBrand,
       this.detail,
       this.price,
       this.discountPrice,
       this.currentHighestBid,
       this.serialNo,
       this.imageUrls,
       this.isOnSale,
       this.isPopular,
       this.isFavorite, 
       this.detailimageUrls});

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
      "brandName": addproduct.proBrand,
      "detail": addproduct.detail,
      "price": addproduct.price,
      "discountPrice": addproduct.discountPrice,
      "serial Code": addproduct.serialNo,
      "ImageUrls": addproduct.imageUrls,
      "detailimageUrls": addproduct.detailimageUrls,
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
        proBrand = snapshot.data()["brandName"],
        detail = snapshot.data()["detail"],
        price = snapshot.data()["price"],
        uid = snapshot.data()['UserID'],
        discountPrice = snapshot.data()["discountPrice"],
        serialNo = snapshot.data()["serial Code"],
        currentHighestBid = snapshot.data()['currentHighestBid'],
        imageUrls = snapshot.data()["ImageUrls"],
        detailimageUrls = snapshot.data()["detailimageUrls"],
        isOnSale = snapshot.data()["isOnSale"],
        isPopular = snapshot.data()["isPopular"],
        isFavorite = snapshot.data()["isFavorite"];
}
