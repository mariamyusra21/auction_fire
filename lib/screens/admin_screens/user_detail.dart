import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
        backgroundColor: Colors.black,
        title: Text('${widget.detailSnapshot.get('displayName')} Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              Text('User Name: ${widget.detailSnapshot['username']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Display Name: ${widget.detailSnapshot['displayName']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Phone Number: ${widget.detailSnapshot['phoneNumber']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Email: ${widget.detailSnapshot['email']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Text('Address: ${widget.detailSnapshot['address']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              BidButton(
                isLoginButton: true,
                color: Colors.black,
                onPress: () {
                  Navigator.pop(context);
                },
                buttonTitle: 'Back',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
