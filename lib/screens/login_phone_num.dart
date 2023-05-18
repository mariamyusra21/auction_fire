import 'package:auction_fire/screens/verify_phone_code.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPhoneNum extends StatefulWidget {
  const LoginPhoneNum({super.key});

  @override
  State<LoginPhoneNum> createState() => _LoginPhoneNumState();
}

class _LoginPhoneNumState extends State<LoginPhoneNum> {
  final phoneNumController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        backgroundColor: Color(0xFFD45A2D),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          TextField(
            controller: phoneNumController,
            decoration: InputDecoration(
                hintText: "+1 234 5678 890",
                hintStyle: TextStyle(fontSize: 20)),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            alignment: Alignment.center,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(colors: [
                  Color(0xFFD45A2D),
                  Color(0xFFBD861C),
                  Color.fromARGB(67, 0, 130, 181)
                ])),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: TextButton(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumController.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (error) {
                        Utilities().toastMessage(error.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                      verificationId: verificationId,
                                    )));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (error) {
                        Utilities().toastMessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
