//import 'dart:io';
import 'dart:io';

import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:auction_fire/widgets/bidtextfield.dart';
import 'package:auction_fire/widgets/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialNoC = TextEditingController();

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
  final imagepicker =
      ImagePicker(); // image picker used to pic any image from storagr
  List<XFile> images =
      []; //XFile will catch all types of images e.g. jpg, pdf, png etc...
  List<String> imageUrls = [];
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

  imagepick() async {
    final List<XFile> imagepick = await imagepicker.pickMultiImage();
    if (imagepick.isNotEmpty) {
      setState(() {
        images.addAll(imagepick);
      });
    } else {
      print('image not selected');
    }
  }

  // post to the firebase storage
  Future postImage(XFile imageFile) async {
    setState(() {
      isUploading = true;
    });
    String urls;
    Reference ref = FirebaseStorage.instance.ref().child("Images").child(
        imageFile.name); // here we set the location of storing file of image
    //after creating instance child images folder will be created and then the path of image where it'll store image
    if (kIsWeb) {
      await ref.putData(
          await imageFile.readAsBytes()); //waiting data to fetch in bytes
      SettableMetadata(
          contentType: "Images/jpeg"); // store image in this format
      urls = await ref
          .getDownloadURL(); // won't upload image without this line the image is not in proper format of image
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImage() async {
    try {
      for (var image in images) {
        await postImage(image)
            .then((downloadUrls) => imageUrls.add(downloadUrls));
      }
    } catch (e) {
      e.toString();
      print(e);
    }
  }

  save() async {
    setState(() {
      isSaving = true; //for loading the products saving
    });

    await uploadImage();
    await Uploadproduct.addProduct(Uploadproduct(
            category: selectedvlaue,
            id: uuid.v4(),
            productName: productNameC.text,
            detail: detailC.text,
            price: int.tryParse(priceC.text),
            discountPrice: int.tryParse(discountPriceC.text),
            serialNo: serialNoC.text,
            imageUrls: imageUrls,
            isOnSale: isOnSale,
            isPopular: isPopular,
            isFavorite: isFavorite))
        .whenComplete(() {
      setState(() {
        imageUrls.clear();
        images.clear();
        clearFields();
        isSaving = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Uploaded Sucessfuly')));
      });
    });
    await FirebaseFirestore.instance
        .collection('Products')
        .add({"images": imageUrls}).whenComplete(() {
      // jub complete ho save prodicts tub setstate me loading band hojaye
      setState(() {
        isSaving = false;
        images.clear();
        imageUrls.clear();
      });
    });
  }

  var uuid = Uuid(); // generate everytime new
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
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
                  const Text(
                    'add products',
                    style: BidStyle.boldStyle,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(
                            0.5), // color of formfeild where we input information like email, password etc
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
                        onPress: () {
                          imagepick();
                        },
                        isLoading: isSaving,
                      ),
                    ),
                  ),
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2 // this will show 2 image in one row in container if we want more than 2 we can increase number
                                ),
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Image.file(
                                File(images[index].path),
                                height: 200,
                                width: 250, //for image size in container
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined))
                            ],
                          );
                        }),
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
}
