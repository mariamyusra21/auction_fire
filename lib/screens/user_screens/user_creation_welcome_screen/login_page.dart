import 'package:auction_fire/screens/user_screens/seller_pages/seller_home_screen.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:auction_fire/widgets/bidtextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final resetEmailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  bool isPassword = true;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    resetEmailController.dispose();
    super.dispose();
  }

  Future<User?> login(email, password) async {
    setState(() {
      loading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .update({
        "password": password,
      });
      //.then((_) {
      //   Utilities().toastMessage('New Password Updated!');
      // });
      // Utilities().toastMessage(userCredential.user!.email.toString());
      return userCredential.user;
    } catch (e) {
      Utilities().toastMessage(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  void resetPasswordEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utilities().toastMessage('Password Reset Email has been sent');
    } on FirebaseAuthException catch (e) {
      // TODO
      Utilities().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 90,),
            // Image.asset('images/ss .png'),
            SizedBox(
              height: 35,
            ),

            Text(
              "Auction Fire",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 550,
              width: 325,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please Login Your Acoount",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 280,
                        child: BidTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          HintText: 'Email Address',
                          icon: Icon(
                            FontAwesomeIcons.envelope,
                            size: 15,
                          ),
                        ),
                      ),
                      Container(
                        width: 280,
                        child: BidTextField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            //obscureText: true,
                            inputAction: TextInputAction.done,
                            HintText: 'Enter Password',
                            isPassword: isPassword,
                            icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                                icon: isPassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Enter a valid password';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'SignUp');
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Change Password'),
                                        content: TextFormField(
                                            controller: resetEmailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                                hintText: 'Email',
                                                helperText: 'Enter your Email',
                                                prefixIcon:
                                                    Icon(Icons.lock_open)),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter a new valid password';
                                              }
                                              return null;
                                            }),
                                        actions: [
                                          IconButton(
                                            onPressed: () {
                                              resetPasswordEmail(
                                                  resetEmailController.text);
                                            },
                                            icon: Icon(Icons.mail_lock),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? user = await login(emailController.text,
                                      passwordController.text);
                                  if (user != null &&
                                      user.emailVerified == true) {
                                    Utilities().toastMessage(
                                        user.email.toString() + ' Logged In');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SellerHomeScreen(user: user)));
                                  } else {
                                    Utilities().toastMessage(
                                        'Please Create Account with another E-mail and verify using our email link!');
                                  }
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Text(
                      //   "Or Login using other account ",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () async {},
                      //       icon: Icon(
                      //         FontAwesomeIcons.google,
                      //         color: Colors.orangeAccent[700],
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: Icon(
                      //         FontAwesomeIcons.facebook,
                      //         color: Colors.orangeAccent[700],
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
