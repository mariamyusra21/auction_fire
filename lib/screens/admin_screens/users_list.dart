import 'package:auction_fire/models/user_data_model.dart';
import 'package:auction_fire/screens/admin_screens/user_detail.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Users Lists'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('emailVerified', isEqualTo: true)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                  snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    final doc = docs[index];
                    final profileImage = doc.data()['photoURL'];
                    final displayName = doc.data()['displayName'];
                    // return UserListTile(userData: doc.data());
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserDetails(detailSnapshot: doc)));
                        },
                        child: Card(
                          elevation: 10.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text('$displayName'),
                              subtitle: Column(
                                children: [
                                  Text('User Name: ${doc.data()['username']}'),
                                  Text('Email: ${doc.data()['email']}'),
                                  Text(
                                      'Phone Number: ${doc.data()['phoneNumber']}'),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //     onPressed: () {}, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                // title: Text(
                                                //     'Are you sure to delete?'),
                                                title: Text('Delete the User?'),
                                                content: Text(
                                                    'Do you want to delete User ${displayName} permanently.'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        UserData.deleteUser(
                                                            doc.id);
                                                      },
                                                      child: Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No')),
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
