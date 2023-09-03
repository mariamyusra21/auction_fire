import 'dart:io';
import 'package:auction_fire/services/storage_service.dart';

import 'package:flutter/material.dart';

class PicUpload extends StatefulWidget {
  const PicUpload({super.key});

  @override
  State<PicUpload> createState() => _MyPicUploadStateState();
}

class _MyPicUploadStateState extends State<PicUpload> {
  @override

 
  Widget build(BuildContext context) {
    final Storage  storage= Storage();
    String? selectedImagePath;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black54
            ),
            child: selectedImagePath != null
      ? Image.file(
        File(selectedImagePath!),
        fit: BoxFit.cover,
      )
      : const Center(
        child: Text('No Image Selected'),
      ),
          ),
          // Center(
            
          //   child: ElevatedButton(onPressed: () async
          //   {
          //     // store file from storage
          //     final result= await FilePicker.platform.pickFiles(
          //       type: FileType.custom,
          //       allowedExtensions: ['png', 'jpg']
          //     );

          //     if(result == null){
          //       ScaffoldMessenger.of(context)
          //       .showSnackBar( const SnackBar(
          //         content: Text('No file selected')));
          //           return null;
          //     } 
          //     // save the pic path and name
          //        final path = result.files.single.path;
          //          final fileName = result.files.single.name;

                   
          //          setState(() {
          //     selectedImagePath = path;
          //        });

          //         //  print(path);
          //         //  print(fileName);
          //         storage.uploadFile(path!, fileName).then((value) => print('done'));
          //   },
          //    child: const Text('upload pic') ),
          // ),


        ],
      ),
    );

  }
}