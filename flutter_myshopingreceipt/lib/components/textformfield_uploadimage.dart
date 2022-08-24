import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TextFormFieldUploadImage extends StatefulWidget {
  String title;
  Function(String filePath) onImageSelected;
  TextFormFieldUploadImage({
    Key? key,
    required this.title,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<TextFormFieldUploadImage> createState() =>
      _TextFormFieldUploadImageState();
}

class _TextFormFieldUploadImageState extends State<TextFormFieldUploadImage> {
  File? imageFile;
  // String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.widget.title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        InkWell(
          onTap: () => _showMyDialog(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 12.0),
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      fit: BoxFit.fitWidth,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey[400],
                          size: 32,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Upload photo here",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih media yang dipilih'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.camera,
                        size: 28,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Kamera",
                        style: TextStyle(color: Colors.grey[700], fontSize: 18),
                      )
                    ],
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        size: 28,
                        color: Colors.grey[700],
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.grey[700], fontSize: 18),
                      )
                    ],
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Get from gallery
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        setState(() {
          // imagePath = image.path;
          widget.onImageSelected(image.path);
          imageFile = File(image.path);
        });
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}
