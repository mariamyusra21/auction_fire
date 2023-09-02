import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String username;
  String phoneNum;
  String email;
  String password;

  UserData({
    required this.username,
    required this.phoneNum,
    required this.email,
    required this.password,
  });

  Future<void> userData(UserData userData) async {
    CollectionReference db = FirebaseFirestore.instance.collection('Users');
    Map<String, dynamic> data = {'username': username, 'phoneNumber': phoneNum};
    await db.add(data);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'phoneNumber': phoneNum,
        'email': email,
        'password': password
      };

  UserData.fromSnapshot(snapshot)
      : username = snapshot.data()['username'],
        phoneNum = snapshot.data()['phoneNumber'],
        email = snapshot.data()['email'],
        password = snapshot.data()['password'];
}
