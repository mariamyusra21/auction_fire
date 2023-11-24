import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String? id;
  String? name;
  int? quantity;
  int? price;
  String? image;

  Cart(
      {required this.id,
      required this.name,
      this.quantity,
      required this.price,
      required this.image});

  static Future<void> AddtoCart(Cart cart) async {
    CollectionReference dbcart =
        FirebaseFirestore.instance.collection('Cart');
    Map<String, dynamic> data = {
      "id": cart.id,
      "ProductName": cart.name,
      "image": cart.image,
      "quantity": cart.id,
      "price": cart.id,
    };
    await dbcart.add(data);
  }
}
