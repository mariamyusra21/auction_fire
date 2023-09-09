import 'dart:io';
import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/screens/user_main_func/upload_image.dart';
import 'package:auction_fire/services/storage_service.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:auction_fire/widgets/bidtextfield.dart';
import 'package:auction_fire/widgets/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart'; // used to generate unique id for anything you want


class AddProduct extends StatefulWidget {
  // const AddProduct({super.key});
  static const String id= 'Addproduct';
   

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController categoryC= TextEditingController();
  TextEditingController idC= TextEditingController();
  TextEditingController productNameC= TextEditingController();
  TextEditingController detailC= TextEditingController();
  TextEditingController priceC= TextEditingController();
  TextEditingController discountPriceC= TextEditingController();
  TextEditingController serialNoC= TextEditingController();
 
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
   final imagepicker = ImagePicker(); // image picker used to pic any image from storagr
   List<File> images = [];  //XFile will catch all types of images e.g. jpg, pdf, png etc... 
   List<String> imageUrls=[];
    bool isSaving=false; //for saving images in firestore 
    bool isUploading= false; //for uplading whole data in firebase

    String? imageUrl;

    clearFields(){
      setState(() {
        selectedvlaue;
        productNameC.clear();
        detailC.clear();
        priceC.clear();
        discountPriceC.clear();
        serialNoC.clear();
        
      });
    }

List<File> selectedImages = [];
 final picker = ImagePicker();
   imagepick() async{
    	final pickedFile = await picker.pickMultiImage(
		requestFullMetadata: true,
		imageQuality: 100,
		maxHeight: 1000,
		maxWidth: 1000);
	List<XFile> xfilePick = pickedFile;

	setState(
	() {
		if (xfilePick.isNotEmpty) {
		for (var i = 0; i < xfilePick.length; i++) {
			selectedImages.add(File(xfilePick[i].path));
		}
		} else {
		ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
			const SnackBar(content: Text('Nothing is selected')));
	}
		}
	);
  //     final List<XFile> imagepick = await imagepicker.pickMultiImage();
  //   // final List<XFile> imagepick = await imagepicker.pickMedia();
  //  setState(() {
  //      if(imagepick.isNotEmpty){
  //     // setState(() {
  //       for (var i = 0; i < imagepick.length; i++) {
	// 		images.add(File(imagepick[i].path));
	// 	}
    
  //     // });
  //   }else{
  //     print('image not selected');
  //   }
  //  });
  
   }
    // post to the firebase storage 
    Future postImage(XFile imageFile) async{
      setState(() {
        isUploading=true;
      });
      String urls ;
     Reference ref= 
     FirebaseStorage.instance.ref().child("Images").child(imageFile.name);  // here we set the location of storing file of image 
     //after creating instance child images folder will be created and then the path of image where it'll store image
     if(imagepick==null){
       await ref.putData(await imageFile.readAsBytes()); //waiting data to fetch in bytes
       SettableMetadata(contentType: "Images/jpeg");     // store image in this format
     urls =await ref.getDownloadURL(); // won't upload image without this line the image is not in proper format of image
    setState(() {
      isUploading=false; 
    });
    return urls;
     }  
    }

    save() async{
    setState(() {
      isSaving=true; //for loading the products saving
    });
    
     PicUpload();
     await Uploadproduct.addProduct(
      Uploadproduct(category: selectedvlaue,
       id: uuid.v4(), 
       productName: productNameC.text, 
       detail: detailC.text, 
       price: int.tryParse(priceC.text), 
       discountPrice: int.tryParse(discountPriceC.text),
        serialNo: serialNoC.text, 
        imageUrls: imageUrls, 
        isOnSale: isOnSale,
         isPopular: isPopular, 
         isFavorite: isFavorite)
     ).whenComplete(() {
      setState(() {
        imageUrls.clear();
        images.clear();
        clearFields(); 
        isSaving= false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Uploaded Sucessfuly')));
      });
     }) ; 

   }
    var uuid = Uuid(); // generate everytime new
    
  @override


  Widget build(BuildContext context) {
    final Storage  storage= Storage();
    String? selectedImagePath;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
            //we will use this code in seller panel
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 9.h),
                child: Column(
                  children: <Widget>[
                    const Text('add products',
                    style: BidStyle.boldStyle,),
                    BidButton(buttonTitle: 'save',
                    onPress: (){
                      save(); 
                    //  PicUpload();
                    }, isLoading: isSaving,
                    
                    ), 
                    Container( 
                      margin: const EdgeInsets.symmetric(horizontal: 13,vertical: 7),
                     decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5) ,     // color of formfeild where we input information like email, password etc
                     borderRadius: BorderRadius.circular(10)
                 ),
                 
                      child: DropdownButtonFormField(
                        hint: const Text('Choose category'),
                        decoration:const  InputDecoration(border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10)),
                        
                        validator: (value){
                          if(value!.isEmpty){
                            return "category must be selected";
                          }
                          return null;
                        },
                        value: selectedvlaue,
                        items: categories
                      .map((e) => DropdownMenuItem<String>(
                       value: e, child: Text(e)))
                       .toList(),
                      onChanged: (value){
                        setState(() {
                           selectedvlaue = value.toString();
                        });
                      }),
                    ), 
    
                                  
                    BidTextField(
                      validate: (v) {
                        if(v.isEmpty){
                          return 'should not be empty';
                        } return null;
                      },
                      HintText: 'Product Name',  
                     controller: productNameC,
                      icon: const Icon(Icons.production_quantity_limits_rounded), 
                      inputAction: TextInputAction.next, 
                      ),
                      BidTextField(
                      validate: (v) {
                        if(v.isEmpty){
                          return 'should not be empty';
                        } return null;
                      },
                     // maxLines: 5,
                      HintText: 'detail of product',   
                     controller: detailC,
                      icon: const Icon(Icons.details), 
                      inputAction: TextInputAction.next, 
                      ),
                      BidTextField(
                      validate: (v) {
                        if(v.isEmpty){
                          return 'should not be empty';
                        } return null;
                      },
                      HintText: 'Prouct Price',  
                     controller: priceC,
                      icon: const Icon(Icons.money), 
                      inputAction: TextInputAction.next, 
                      ),
                       BidTextField(
                      validate: (v) {
                        if(v.isEmpty){
                          return 'should not be empty';
                        } return null;
                      },
                      HintText: 'Discount',  
                     controller: discountPriceC,
                      icon: const Icon(Icons.money), 
                      inputAction: TextInputAction.next, 
                      ),
                       BidTextField(
                      validate: (v) {
                        if(v.isEmpty){
                          return 'should not be empty';
                        } return null;
                      },
                      HintText: 'Serial Code',  
                     controller: serialNoC,
                      icon: const Icon(Icons.sell_rounded), 
                      inputAction: TextInputAction.next, 
                      ),
    
                    BidButton(
                      buttonTitle: "Choose image",
                      onPress: ()  async{
                         imagepick();
                  //       // store file from storage
                  // final result= await FilePicker.platform.pickFiles(
                  //   type: FileType.custom,
                  //   allowedExtensions: ['png', 'jpg']
                  // );

                  // if(result == null){
                  //   ScaffoldMessenger.of(context)
                  //   .showSnackBar( const SnackBar(
                  //     content: Text('No file selected')));
                  //       return null;
                  // } 
                  // // save the pic path and name
                  //    final path = result.files.single.path;
                  //      final fileName = result.files.single.name;

                       
                  //      setState(() {
                  // selectedImagePath = fileName;
                  //    });

                  //     //  print(path);
                  //     //  print(fileName);
                  //     storage.uploadFile(path!, fileName).then((value) => print('done'));
 

                      }, isLoading: isSaving,
                    ),
                    Container(
                         height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child:  SizedBox(
				width: 300.0,
				child: selectedImages.isEmpty
					? const Center(child: Text('Sorry nothing selected!!'))
					: GridView.builder(
						itemCount: selectedImages
							.length,
						gridDelegate:
							const SliverGridDelegateWithFixedCrossAxisCount(
								crossAxisCount: 3),
						itemBuilder: (BuildContext context, int index) {
						return Center(
							child:
								kIsWeb
									? Image.network(
										selectedImages[index].path,
										height:
											100,
										width: 100,
										fit: BoxFit
											.fill,
										alignment: Alignment
											.center,
										)
									: Image.file(
										selectedImages[index],
										height:
											100,
										width: 100,
										fit: BoxFit
											.fill,
										alignment: Alignment
											.center,
								));
						},
				),
			),
			
                    // GridView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2 // this will show 2 image in one row in container if we want more than 2 we can increase number
                    //   ),
                    //   itemCount: images.length, 
                    // itemBuilder: (BuildContext context, int index) {
                    //   return   Column(
                    //     children: [ 
                        
                    //         kIsWeb
                    //       ? Image.network(
                    //         images[index].path,
                    //         height:
                    //           100,
                    //         width: 100,
                    //         fit: BoxFit
                    //           .cover,
                    //         alignment: Alignment
                    //           .center,
                    //         )
                    //       : Image.file(
                    //         images[index],
                    //         height:
                    //           100,
                    //         width: 100,
                    //         fit: BoxFit
                    //           .fill,
                    //         alignment: Alignment
                    //           .center,
                    //     ),
                    //       IconButton(onPressed: (){
                    //        setState(() {
                    //           images.removeAt(index);
                    //        });
                    //       }, icon: const Icon(Icons.cancel_outlined))
                    //     ],
                    //   );
                    // }),
                  
                    
                    ),
                    
                    SwitchListTile(
                      title: const Text('Is this on Sale?'),
                      value: isOnSale, 
                    onChanged: (v){
                      setState(() {
                        isOnSale =! isOnSale;
                      });
                    }),
                    SwitchListTile(
                      title: const Text('Is this popular'),
                      value: isPopular, 
                    onChanged: (v){
                      setState(() {
                        isPopular =! isPopular;
                      });
                    }),
                    // BidButton(buttonTitle: 'save',
                    // onPress: (){
                    //   save(); 
                      
                    // }, isLoading: isSaving,
                    
                    // ), 
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}