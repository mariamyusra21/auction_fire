import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  // documnetSnapshot jo bhi firestore documnets ki feilds hogi use return karwake deta he
  static Future<DocumentSnapshot> adminSignIn(id) async {
    var result = FirebaseFirestore.instance.collection("admins").doc(id).get();
    return result;
  }

  static Future<String> getCurrentUID() async {
    return (await FirebaseAuth.instance.currentUser)!.uid;
  }

  static Future getCurrentUser() async {
    return (await FirebaseAuth.instance.currentUser);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
