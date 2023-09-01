import 'dart:io';
import 'package:auction_fire/models/add_product_model.dart';
import 'package:auction_fire/widgets/bid_color.dart';
import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:auction_fire/widgets/bidtextfield.dart';
import 'package:auction_fire/widgets/styles.dart';
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
   List<XFile> images = [];  //XFile will catch all types of images e.g. jpg, pdf, png etc... 
   List<String> imageUrls=[];
    bool isSaving=false; //for saving images in firestore 
    bool isUploading= false; //for uplading whole data in firebase

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


   imagepick() async{
    final List<XFile> imagepick = await imagepicker.pickMultiImage();
    if(imagepick.isNotEmpty){
      setState(() {
        images.addAll(imagepick);
      });
    }else{
      print('image not selected');
    }
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
     if(kIsWeb){
       await ref.putData(await imageFile.readAsBytes()); //waiting data to fetch in bytes
       SettableMetadata(contentType: "Images/jpeg");     // store image in this format
     urls =await ref.getDownloadURL(); // won't upload image without this line the image is not in proper format of image
    setState(() {
      isUploading=false; 
    });
    return urls;
     }  
    }

    uploadImage() async{
      for (var image in images) {
        await postImage(image).then((downloadUrls) => imageUrls.add(downloadUrls));
      }
    }

   save() async{
    setState(() {
      isSaving=true; //for loading the products saving
    });
    
     await uploadImage();
     await Uploadproduct.addProduct(
      Uploadproduct(category: selectedvlaue,
       id: uuid.v4(), 
       productName: productNameC.text, 
       detail: detailC.text, 
       price: int.parse(priceC.text), 
       discountPrice: int.parse(discountPriceC.text),
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
    
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          
        //we will use this code in seller panel
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 9.h),
            child: Column(
              children: [
                  
                const Text('add products',
                style: BidStyle.boldStyle,),
                BidButton(buttonTitle: 'save',
                onPress: (){
                  save(); 
                  
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
    
                // BidButton(
                //   buttonTitle: "Choose image",
                //   onPress: () {
                //     imagepick();
                //   }, isLoading: isSaving,
                // ),
                // Container(
                //   height: 45.h,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.withOpacity(0.4),
                //     borderRadius: BorderRadius.circular(20)
                //   ),
                //   child: GridView.builder(
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2 // this will show 2 image in one row in container if we want more than 2 we can increase number
                //       ),
                //       itemCount: images.length, 
                //     itemBuilder: (BuildContext context, int index) {
                //       //(File(images[index].path).path)    this will fetch image file from network gives us link 
                //       // in link first image index path is images path and second one is document path
                //       // if we want to access or pick images from memory we should use memory instead of network
                //       return Stack(
                //         children: [
                //           Image.network(File(images[index].path).path,
                //           height: 200, width: 250, //for image size in container
                //           fit: BoxFit.cover,
                //           ),
                //           IconButton(onPressed: (){
                //            setState(() {
                //               images.removeAt(index);
                //            });
                //           }, icon: const Icon(Icons.cancel_outlined))
                //         ],
                //       );
                //     }),
                // ),
                
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
      ),
    )   ;
  }
}