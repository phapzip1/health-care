import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final void Function(File value) onPicked;
  final String defaultImageUrl;
  const AvatarPicker({super.key, required this.onPicked, required this.defaultImageUrl});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  var _selectedImage = null;

  @override
  void initState() {
    super.initState();
  }

  void _pickImage() async {
    final pickImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickImage == null) return;
    setState(() {
      _selectedImage = File(pickImage.path);
    });
    widget.onPicked(_selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider image = NetworkImage(widget.defaultImageUrl);
    if (_selectedImage != null) {
      image = FileImage(_selectedImage);
    }
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 56.0,
          backgroundColor: Colors.white,
          backgroundImage: image,
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: CircleAvatar(
            
            backgroundColor: Colors.grey[200],
            radius: 16.0,
            child: IconButton(
              onPressed: _pickImage,
              icon: const Icon(
                Icons.camera_alt,
                size: 16.0,
                color: Color(0xFF404040),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
