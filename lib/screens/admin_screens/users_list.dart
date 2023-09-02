import 'package:auction_fire/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference referenceUsers =
      FirebaseFirestore.instance.collection('Users');

  List<Object> usersList = [];
  Future getUsersList() async {
    final uid = auth.currentUser!.uid;
    var data =
        await referenceUsers.orderBy('username', descending: false).get();

    setState(() {
      usersList = List.from(data.docs.map((doc) => UserData.fromSnapshot(doc)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Lists'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            return UserListTile(userData: usersList[index] as UserData);
          }),
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${userData.username}'),
      subtitle: Text('${userData.password}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: Text(
              "Edit",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
            onPressed: () {},
          ),
          TextButton(
            child: Text("Delete",
                style: TextStyle(color: Colors.red, fontSize: 15)),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
