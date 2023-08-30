import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String username;
  String phoneNum;

  UserData({required this.username, required this.phoneNum});

  Future<void> userData(UserData userData) async {
    CollectionReference db = FirebaseFirestore.instance.collection('Users');
    Map<String, dynamic> data = {'username': username, 'phoneNumber': phoneNum};
    await db.add(data);
  }
}
