import 'dart:io';

import 'package:auction_fire/screens/user_screens/login_page.dart';
import 'package:auction_fire/services/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  // final User? user;
  const UserProfile({
    super.key,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final displayNameC = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late User? user = FirebaseAuth.instance.currentUser;

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
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Setting up Your Profile",
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
                          // Text(
                          //   'Setting up Your Profile',
                          //   style: TextStyle(
                          //     fontSize: 35,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "Please Enter Your Profile Information",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              image != null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundImage: FileImage(image!),
                                    )
                                  : CircleAvatar(
                                      radius: 64,
                                      backgroundImage: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThlTauvFuw7q1xluWrxtf2uFBYgaa_a2GQfg&usqp=CAU'),
                                    ),
                              Positioned(
                                child: IconButton(
                                    onPressed: () => imagePickerMethod(),
                                    icon: Icon(Icons.add_a_photo_outlined)),
                                bottom: -10,
                                left: 80,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              controller: addressController,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                  labelText: "Address",
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.user,
                                    size: 15,
                                  )),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await updateProfile(
                                  displayNameC.text, addressController.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              "SignUp",
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

  File? image;
  final imagePicker = ImagePicker();
  dynamic imageUrls;
  final firebaseStorageRef = FirebaseStorage.instance;
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  // Update Profile to store the data in user document
  Future updateProfile(String displayName, String address) async {
    imageUrls = await uploadImage();
    await firestoreRef
        .collection('Users')
        .doc(user!.uid)
        .update({
          'displayName': displayName,
          'photoURL': imageUrls,
          'address': address
        })
        .then((value) => Utilities().toastMessage('Profile has been updated'))
        .onError(
            (error, stackTrace) => Utilities().toastMessage(error.toString()));
  }

  // Image pick method to select image from storage
  Future imagePickerMethod() async {
    // image pick from gallery
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        image = File(pick.path);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No Image Selected')));
      }
    });
  }

  // upload image to firebase storage
  Future<String> uploadImage() async {
    if (image != null) {
      try {
        var snapshot = await firebaseStorageRef
            .ref()
            .child('user_profiles/${DateTime.now()}.jpg')
            .putFile(image!);
        // UploadTask uploadTask = firebaseStorageRef.putFile(image!);
        // await uploadTask.whenComplete(() => print('Image uploaded'));
        var downlodurl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrls = downlodurl;
          // imageUrls.add(downlodurl);
          print(imageUrls);
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('No image to upload.');
    }
    return imageUrls;
  }
}
