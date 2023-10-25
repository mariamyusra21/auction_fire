import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
   late String username;
  String? phoneNum;
  String? email;
  String? password;
  String? address;
  String? displayName;
  dynamic profilePic;

  UserData();

  Future<void> userData(UserData userData) async {
    CollectionReference db = FirebaseFirestore.instance.collection('Users');
    Map<String, dynamic> data = {'username': username, 'phoneNumber': phoneNum};
    await db.add(data);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'phoneNumber': phoneNum,
        'email': email,
        'password': password,
        'displayName': displayName,
        'address': address,
        'profilePic': profilePic
      };

  UserData.fromSnapshot(snapshot)
      : username = snapshot.data()['username'],
        phoneNum = snapshot.data()['phoneNumber'],
        email = snapshot.data()['email'],
        password = snapshot.data()['password'],
        address = snapshot.data()['address'],
        displayName = snapshot.data()['displayName'],
        profilePic = snapshot.data()['profilePic'];
}
