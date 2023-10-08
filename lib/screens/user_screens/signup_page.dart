import 'package:auction_fire/screens/user_screens/signup_verification/verify_sms_code.dart';
import 'package:auction_fire/screens/user_screens/user_profile.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumController = TextEditingController();
  final confirmPassController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late int emailRadioTile;
  late int numRadioTile;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailRadioTile = 0;
    numRadioTile = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumController.dispose();
    confirmPassController.dispose();
    usernameController.dispose();
  }

  void verifyEmail(String email) {
    //verification code comes here..
  }

  void verifyPhoneNum(number) {
    auth
        .verifyPhoneNumber(
            phoneNumber: number.toString(),
            verificationCompleted: (_) {},
            verificationFailed: (error) {
              Utilities().toastMessage(error.toString());
            },
            codeSent: (String verificationId, int? token) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifySMSCode(
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
            })
        .then((value) => signup(emailController.text, passwordController.text));
  }

  void signup(email, password) {
    setState(() {
      loading = true;
    });

    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (auth.currentUser!.email!.endsWith('@gmail.com')) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .set({
          'username': usernameController.text,
          'email': email,
          'phoneNumber': phoneNumController.text,
          'password': password
        });
        Utilities().toastMessage('Account Created Successfully');
      }
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utilities().toastMessage(error.toString());
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
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
                  height: 15,
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
                  height: 600,
                  width: 325,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please create your Acoount",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: usernameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: "User Name",
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.user,
                                    size: 15,
                                  )),
                            ),
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Email Address",
                                  helperText:
                                      'Enter a valid email e.g john@gmail.com',
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.envelope,
                                    size: 15,
                                  )),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Enter a valid email';
                              //   }
                              //   return null;
                              // },
                              validator: Validators.compose([
                                Validators.required('email is required'),
                                Validators.email('invalid email')
                              ]),
                            ),
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: phoneNumController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: "Phone_Number",
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.phone,
                                    size: 15,
                                  )),
                            ),
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.eyeSlash,
                                      size: 15,
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter a valid password';
                                  }
                                  return null;
                                }),
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: confirmPassController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    size: 15,
                                  )),
                            ),
                          ),
                          // RadioListTiles for verification for signup through email and phone number.
                          // RadioListTile for Email Verification
                          RadioListTile(
                            title: Text(
                              'Verify with Email',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 1,
                            groupValue: emailRadioTile,
                            onChanged: ((value) {
                              setState(() {
                                emailRadioTile = value!;
                              });
                              if (emailRadioTile == 1) {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SellerHomeScreen()));
                              }
                            }),
                          ),
                          // RadioListTile for Number Verification
                          RadioListTile(
                            title: Text(
                              'Verify with Phone Number',
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 1,
                            groupValue: numRadioTile,
                            onChanged: ((value) {
                              setState(() {
                                numRadioTile = value!;
                              });
                              // if (numRadioTile == 1) {
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               VerifyPhoneNumber()));
                              // }
                            }),
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                          ),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(colors: [
                                    Color(0xFFD45A2D),
                                    Color(0xFFBD861C),
                                    Color.fromARGB(67, 0, 130, 181)
                                  ])),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // if (numRadioTile == 1) {
                                    //   // phone number verifiction method for code retrival
                                    //   verifyPhoneNum(phoneNumController.value);
                                    //   // signup(emailController.text,
                                    //   //     passwordController.text);
                                    // } else if (emailRadioTile == 1) {
                                    //   // email verification code comes here...
                                    // }

                                    signup(emailController.text,
                                        passwordController.text);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfile()));
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'LoginPage');
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  color: Colors.orangeAccent[700],
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
