import 'dart:io';
import 'package:auction_fire/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
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
        File(selectedImagePath),
        fit: BoxFit.cover,
      )
      : const Center(
        child: Text('No Image Selected'),
      ),
          ),

        ],
      ),
    );

  }
}