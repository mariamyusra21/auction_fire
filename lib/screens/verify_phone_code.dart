import 'package:auction_fire/screens/home_screen.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verifyCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VERIFICATION VIA CODE",
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
            controller: verifyCodeController,
            decoration: InputDecoration(
                hintText: "6 digit code", hintStyle: TextStyle(fontSize: 20)),
            keyboardType: TextInputType.number,
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
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    final credintial = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: verifyCodeController.text);
                    try {
                      await auth.signInWithCredential(credintial);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                      setState(() {
                        loading = false;
                      });
                    } catch (e) {
                      Utilities().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
