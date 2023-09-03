import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  final DocumentSnapshot detailSnapshot;
  const UserDetails({super.key, required this.detailSnapshot});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference referenceUsers =
      FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Details'),
        centerTitle: true,
      ),
      // body: ListView.builder(
      //     itemCount: usersList.length,
      //     itemBuilder: (context, index) {
      //       return Details(userData: usersList.)
      //     }),
      body: Column(
        children: [
          Text(widget.detailSnapshot.get('username')),
          Text(widget.detailSnapshot.get({'phoneNumber'})),
          Text(widget.detailSnapshot.get({'email'})),
          Text(widget.detailSnapshot.get({'password'})),
        ],
      ),
    );
  }
}
