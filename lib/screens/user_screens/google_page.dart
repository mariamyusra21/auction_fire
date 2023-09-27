// import 'package:auction_fire/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../services/utilities.dart';

// class GoogleSignIn extends StatefulWidget {
//   GoogleSignIn({Key? key}) : super(key: key);

//   @override
//   _GoogleSignInState createState() => _GoogleSignInState();
// }

// class _GoogleSignInState extends State<GoogleSignIn> {
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return !isLoading
//         ? SizedBox(
//             width: size.width * 0.8,
//             child: ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   isLoading = true;
//                 });
//                 FirebaseService service = new FirebaseService();
//                 try {
//                   await service.signInwithGoogle();
//                   // ignore: use_build_context_synchronously
//                   Navigator.push(context, const HomeScreen() as Route<Object?>);
//                 } catch (e) {
//                   if (e is FirebaseAuthException) {
//                     Utilities().toastMessage(e.toString());
//                   }
//                 }
//                 setState(() {
//                   isLoading = false;
//                 });
//               },
//               child: Text(
//                 'Sign In with Google',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               style: ButtonStyle(
//                   side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
//             ),
//           )
//         : CircularProgressIndicator();
//   }
// }
