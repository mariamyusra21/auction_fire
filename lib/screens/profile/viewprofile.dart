import 'package:auction_fire/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wc_form_validators/wc_form_validators.dart';


class ProfileData extends StatefulWidget {
  final User? user;
  ProfileData({super.key, required this.user});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameC = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  dynamic profilePic;
  FirebaseAuth auth = FirebaseAuth.instance;
 

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (FirebaseAuth.instance.currentUser!.displayName == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('please complete profile firstly')));
      // } else {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(widget.user!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          usernameController.text = snapshot['username'];
          emailController.text = snapshot['email'];
          phoneNumController.text = snapshot['phoneNumber'];
          displayNameC.text = snapshot['displayName'];
          addressController.text = snapshot['address'];
         
          profilePic = snapshot['photoURL'];
        }
        );
      //}
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    displayNameC.dispose();
    phoneNumController.dispose();
    addressController.dispose();
    usernameController.dispose();
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
                  "PROFILE",
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
                          const SizedBox(
                            height: 30,
                          ),
                          
                          CircleAvatar(
                          radius: 64,

                             backgroundImage: 
                            // NetworkImage(profilePic)
                            profilePic == null
                            ? Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThlTauvFuw7q1xluWrxtf2uFBYgaa_a2GQfg&usqp=CAU').image
                            : NetworkImage(profilePic)
                            
                          ),const Text("Profile Picture"),
                        // const  Text(
                        //     'Profile',
                        //     style: TextStyle(
                        //       fontSize: 35,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "Please create your Acoount",
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
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
                                controller: displayNameC,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    labelText: "Display Name",
                                    suffixIcon: Icon(
                                      FontAwesomeIcons.user,
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Email Address",
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
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: "Address",
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.addressBook,
                                    size: 15,
                                  )),
                            ),
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
                                    // form validation
                                  }
                                },
                                child: Text(
                                  "Update & Save",
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
                              Navigator.pop(context);
                              // Navigator.pushNamed(context, 'LoginPage');
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

  // save updated data 


}
