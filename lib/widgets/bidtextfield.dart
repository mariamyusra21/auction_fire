import 'package:flutter/material.dart';

class BidTextField extends StatefulWidget {

   String HintText;
 bool isPassword; 
 TextEditingController controller;
  //  String? Function(String?)? validate;
bool check;  //used to check whether the textfeild is password if yes then visibility should turn on and off
Widget icon;
int? maxLines;
final TextInputAction? inputAction;  // use to change one action button in keyboard can go through that button to next textfeild
// late FocusNode focusNode;
   BidTextField( {super.key , 
   required this.HintText, 
   required this.controller,
   //required this.validate,
   this.maxLines,
   this.isPassword=false,
   this.check=false,
   required this.icon,
   this.inputAction, 
    String? Function(String v)? validate, 
   //required this.focusNode
   });
 


  @override
  State<BidTextField> createState() => _BidTextFieldState();
}

class _BidTextFieldState extends State<BidTextField> {


//  String? Function(String?)? validate;

 // late final FocusNode focusNode;

// for icon where it should appear as visiblity an where it should be appear an email 
  @override  
  Widget build(BuildContext context) {
     TextInputAction? inputAction;
    //  int maxLines;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13,vertical: 7),
       decoration: BoxDecoration(
         color: Colors.white,     // color of formfeild where we input information like email, password etc
         borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
        
          //the below validator will show same message in all fields
          // validator: (v){  
          //   if(v!.isEmpty){
          //       return "something wrong";
          //   }
          // },
          obscureText: widget.isPassword==false?false: widget.isPassword,
          //validator: validate,
          controller: widget.controller,
          // maxLines: widget.maxLines==1 ? 1 :widget.maxLines,
          // focusNode: focusNode,
          textInputAction: inputAction,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: widget.HintText,
            suffixIcon: widget.icon,
            // suffixIcon: IconButton(onPressed: (){
            //   if(check ==false){ //agr password ki feild nhi hogi to waha ye icon nhi hoga 
            //   isPassword=true;
            //   check=true;
            //   }
            //   else{
            //     isPassword= false;
            //     check=false;
            //   }
            // }, icon: ),
            // iconChecker(),
           // isPassword==false ?Icon(Icons.visibility):Icon(Icons.visibility_off),),
            //isPassword==true?const Icon(Icons.visibility): const Icon(Icons.email),
          
            // to showm 'enter email in normal way
             contentPadding: EdgeInsets.all(10)
            
          ),
        ),
    );
  }
}