import 'dart:async';

import 'package:auction_fire/screens/profile/user_profile.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool? isEmailVerified;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  // late User user = widget.user;

  Timer? timer;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(
        const Duration(seconds: 5), (timer) => checkEmailVerified());
    super.initState();
  }

  Future<void> checkEmailVerified() async {
    // Ensure that currentUser is not null
    final currentUser = FirebaseAuth.instance.currentUser;

    // user = auth.currentUser;
    // await user?.reload();
    // if (user != null && user!.emailVerified) {
    //   timer?.cancel();
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));
    //   signup(widget.email, widget.password);
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => UserProfile()));
    // }

    if (currentUser != null) {
      await currentUser.reload();

      setState(() {
        isEmailVerified = currentUser.emailVerified;
      });

      if (isEmailVerified == true) {
        // TODO: Implement your code after email
        Utilities().toastMessage(
            "Your Email ${currentUser.email} is Successfully Verified. \n Please Update your Profile otherwise your Account will be deleted!");

        // Update the user data email is verified
        FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .update({
          'emailVerified': isEmailVerified,
        });

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UserProfile()));
        timer?.cancel();
      }
    } else {
      // Handle the case where currentUser is null (user not authenticated)
      Utilities().toastMessage("User not found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFFD45A2D),
                  Color(0xFFBD861C),
                  Color.fromARGB(67, 0, 130, 181)
                ])),
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Verify Email Through Link",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 550,
                  width: 325,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 35),
                          const SizedBox(height: 30),
                          const Center(
                            child: Text(
                              'Check your \n Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Center(
                              child: Text(
                                'We have sent you a Email on  ${auth.currentUser?.email}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Center(child: CircularProgressIndicator()),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0),
                            child: Center(
                              child: Text(
                                'Verifying email....',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 57),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFFD45A2D),
                                      Color(0xFFBD861C),
                                      Color.fromARGB(67, 0, 130, 181)
                                    ])),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: TextButton(
                                    child: const Text(
                                      'Resend',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      try {
                                        auth.currentUser
                                            ?.sendEmailVerification();
                                      } catch (e) {
                                        debugPrint('$e');
                                        Utilities().toastMessage(e.toString());
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
}
