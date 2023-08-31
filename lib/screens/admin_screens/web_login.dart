import 'package:auction_fire/screens/admin_screens/web_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../services/firebase_services.dart';
import '../../widgets/bid_dialogue.dart';
import '../../widgets/bidbutton.dart';
import '../../widgets/bidtextfield.dart';
import '../../widgets/styles.dart';

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({Key? key}) : super(key: key);
  final String id = "weblogin";
  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  TextEditingController userNameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirebaseServices.adminSignIn(userNameC.text).then((value) async {
        if (value['name'] == userNameC.text &&
            value['password'] == passwordC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              Navigator.pushReplacementNamed(context, WebMainScreen.id);
            }
          } catch (e) {
            setState(() {
              formStateLoading = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return bidDialogue(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "WELCOME ADMIN",
                      style: BidStyle.boldStyle,
                    ),
                    const Text(
                      "Log in to your Account",
                      style: BidStyle.boldStyle,
                    ),
                    BidTextField(
                      controller: userNameC,
                      HintText: "UserName...",
                      validate: (v) {
                        if (v.isEmpty) {
                          return "email should not be empty";
                        }
                        return null;
                      },
                      inputAction: TextInputAction.next,
                      icon: const Icon(Icons.admin_panel_settings_sharp),
                    ),
                    BidTextField(
                      controller: passwordC,
                      isPassword: true,
                      HintText: "Password...",
                      validate: (v) {
                        if (v.isEmpty) {
                          return "password should not be empty";
                        }
                        return null;
                      },
                      icon: const Icon(Icons.password),
                      inputAction: TextInputAction.done,
                    ),
                    BidButton(
                      isLoginButton: true,
                      isLoading: formStateLoading,
                      onPress: () {
                        submit(context);
                      },
                      buttonTitle: 'Login',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
