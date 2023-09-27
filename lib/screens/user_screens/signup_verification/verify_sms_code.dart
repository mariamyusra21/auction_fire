import 'package:auction_fire/screens/user_screens/login_page.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifySMSCode extends StatefulWidget {
  final String verificationId;
  const VerifySMSCode({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<VerifySMSCode> createState() => _VerifySMSCodeState();
}

class _VerifySMSCodeState extends State<VerifySMSCode> {
  final verifyCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        centerTitle: true,
        title: Text('Verify Code'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFD45A2D),
          Color(0xFFBD861C),
          Color.fromARGB(67, 0, 130, 181)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  TextFormField(
                    controller: verifyCodeController,
                    decoration: InputDecoration(
                        hintText: "6 digit code",
                        hintStyle: TextStyle(fontSize: 20)),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(colors: [
                              Color(0xFFD45A2D),
                              Color(0xFFBD861C),
                              Color.fromARGB(67, 0, 130, 181)
                            ])),
                        child: BidButton(
                          buttonTitle: "Place bid",
                          onPress: () async {
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
                                      builder: (context) => LoginPage()));
                              setState(() {
                                loading = false;
                              });
                            } catch (e) {
                              Utilities().toastMessage(e.toString());
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
