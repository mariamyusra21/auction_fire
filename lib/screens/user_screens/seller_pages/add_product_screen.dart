//import 'dart:io';
import 'dart:io';

import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:auction_fire/widgets/bidtextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart'; // used to generate unique id for anything you want

class AddProduct extends StatefulWidget {
  // const AddProduct({super.key});
  static const String id = 'Addproduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController categoryC = TextEditingController();
  // TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController brandNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialNoC = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavorite = false;

  String? selectedvlaue;
  List categories = [
    "Garments",
    "Electronics",
    "Jewllery",
    "Foot_Wear",
    "Cosmatics",
    "Stationary"
  ];
  // veriables for deatil images
  final imagepicker =
      ImagePicker(); // image picker used to pic any image from storagr
  List<XFile> detailimages =
      []; //XFile will catch all types of images e.g. jpg, pdf, png etc...
  List<dynamic> detailimageUrls = [];
  bool isSaving = false; //for saving images in firestore
  bool isUploading = false; //for uplading whole data in firebase

  clearFields() {
    setState(() {
      selectedvlaue;
      productNameC.clear();
      detailC.clear();
      priceC.clear();
      discountPriceC.clear();
      serialNoC.clear();
    });
  }

// chose images for deatil pages methods
  // final Storage storage = Storage();

  imagepick() async {
    final List<XFile> imagepick = await imagepicker.pickMultiImage();
    if (imagepick.isNotEmpty) {
      setState(() {
        detailimages.addAll(imagepick);
      });
    } else {
      print('image not selected');
    }
  }

//   // post to the firebase storage
  Future postImage(XFile imageFile) async {
    setState(() {
      isUploading = true;
    });
    String urls;
    Reference ref = FirebaseStorage.instance.ref().child("images").child(
        imageFile.name); // here we set the location of storing file of image
    //after creating instance child images folder will be created and then the path of image where it'll store image
    if (kIsWeb == false) {
      await ref.putData(
          await imageFile.readAsBytes()); //waiting data to fetch in bytes
      SettableMetadata(contentType: "image/jpeg"); // store image in this format
      urls = await ref
          .getDownloadURL(); // won't upload image without this line the image is not in proper format of image
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadDetailImages() async {
    try {
      for (var image in detailimages) {
        await postImage(image)
            .then((downloadUrls) => detailimageUrls.add(downloadUrls));
      }
    } catch (e) {
      e.toString();
      print(e);
    }
  }

  // save all feilds in firebasefirestore
  save() async {
    setState(() {
      isSaving = true; //for loading the products saving
    });
    await uploadDetailImages();
    await uploadImage();
    if (imageUrls != null) {
      //&& detailimageUrls == true
      await Uploadproduct.addProduct(Uploadproduct(
        category: selectedvlaue,
        // id: uuid.v4(),
        // id: idC.text,
        productName: productNameC.text,
        proBrand: brandNameC.text,
        detail: detailC.text,
        price: int.tryParse(priceC.text),
        uid: user!.uid,
        discountPrice: int.tryParse(discountPriceC.text),
        currentHighestBid: int.tryParse(priceC.text),
        serialNo: serialNoC.text,
        imageUrls: imageUrls,
        detailimageUrls: detailimageUrls,
        isOnSale: isOnSale,
        isPopular: isPopular,
        isFavorite: isFavorite,
      )).whenComplete(() {
        setState(() {
          // imageUrls.clear();
          // image!.clear();
          // clearFields();
          isSaving = false;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Uploaded Sucessfuly')));
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('must be all fields filled')));
    }
  }

  var uuid = Uuid(); // generate everytime new
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: Text(
          'Add Product',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(colors: [
          Color(0xFFD45A2D),
          Color(0xFFBD861C),
          Color.fromARGB(67, 0, 130, 181)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SingleChildScrollView(
          child: Center(
            //we will use this code in seller panel
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
              child: Column(
                children: [
                  // const Text(
                  //   'add products',
                  //   style: BidStyle.boldStyle,
                  // ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            0.4), // color of formfeild where we input information like email, password etc
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField(
                        hint: const Text('Choose category'),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "category must be selected";
                          }
                          return null;
                        },
                        value: selectedvlaue,
                        items: categories
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedvlaue = value.toString();
                          });
                        }),
                  ),
                  BidTextField(
                    validate: (v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    HintText: 'Product Name',
                    controller: productNameC,
                    icon: const Icon(Icons.production_quantity_limits_rounded),
                    inputAction: TextInputAction.next,
                  ),
                  BidTextField(
                    validate: (v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    HintText: 'Brand Name',
                    controller: brandNameC,
                    icon: const Icon(Icons.branding_watermark_outlined),
                    inputAction: TextInputAction.next,
                  ),
                  BidTextField(
                    validate: (v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    // maxLines: 5,
                    HintText: 'detail of product',
                    controller: detailC,
                    icon: const Icon(Icons.details),
                    inputAction: TextInputAction.next,
                  ),
                  BidTextField(
                    validate: (v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    HintText: 'Prouct Price',
                    controller: priceC,
                    icon: const Icon(Icons.money),
                    inputAction: TextInputAction.next,
                  ),
                  BidTextField(
                    validate: (v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    HintText: 'Discount',
                    controller: discountPriceC,
                    icon: const Icon(Icons.money),
                    inputAction: TextInputAction.next,
                  ),
                  BidTextField(
                    validate: (v) {
                      if (v.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                    HintText: 'Serial Code',
                    controller: serialNoC,
                    icon: const Icon(Icons.sell_rounded),
                    inputAction: TextInputAction.next,
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(colors: [
                            Color(0xFFD45A2D),
                            Color(0xFFBD861C),
                            Color.fromARGB(67, 0, 130, 181)
                          ])),
                      child: BidButton(
                        buttonTitle: "Choose image",
                        onPress: () async {
                          imagepick();
                        },
                        isLoading: isSaving,
                      ),
                    ),
                  ),
                  // //choose images for detail page
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2 // this will show 2 image in one row in container if we want more than 2 we can increase number
                                ),
                        itemCount: detailimages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(detailimages[index].path),
                                  height: 200,
                                  width: 250, //for image size in container
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        detailimages.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.cancel_outlined))
                              ],
                            ),
                          );
                        }),
                  ),

                  // choose image for thumbnail
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          ImagePickerMethod();
                        },
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        1 // this will show 2 image in one row in container if we want more than 2 we can increase number
                                    ),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    image == null
                                        ? const Padding(
                                            padding: EdgeInsets.all(60.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'choose image for showcase of product'),
                                                  Icon(Icons.add),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Image.file(image!),
                                    //      IconButton(onPressed: (){
                                    //  setState(() {
                                    // detailimages.removeAt(index);
                                    // });
                                    // }, icon: const Icon(Icons.cancel_outlined))
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),

                  SwitchListTile(
                      title: const Text('Is this on Sale?'),
                      value: isOnSale,
                      onChanged: (v) {
                        setState(() {
                          isOnSale = !isOnSale;
                        });
                      }),
                  SwitchListTile(
                      title: const Text('Is this popular'),
                      value: isPopular,
                      onChanged: (v) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      }),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(colors: [
                            Color(0xFFD45A2D),
                            Color(0xFFBD861C),
                            Color.fromARGB(67, 0, 130, 181)
                          ])),
                      child: BidButton(
                        buttonTitle: 'save',
                        onPress: () {
                          save();
                          // uploadImage();
                        },
                        isLoading: isSaving,
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

  // use for thumbnail of product
  File? image;
  final imagePicker = ImagePicker();
  dynamic imageUrls;
  final firebaseStorageRef = FirebaseStorage.instance;

  Future ImagePickerMethod() async {
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
  Future uploadImage() async {
    if (image != null) {
      try {
        var snapshot = await firebaseStorageRef
            .ref()
            .child('images/${DateTime.now()}.jpg')
            .putFile(image!);
        // UploadTask uploadTask = firebaseStorageRef.putFile(image!);
        // await uploadTask.whenComplete(() => print('Image uploaded'));
        var downlodurl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrls = downlodurl;
          imageUrls.add(downlodurl);
          print(imageUrls);
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      print('No image to upload.');
    }
  }
}
