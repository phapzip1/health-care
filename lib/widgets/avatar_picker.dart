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
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: CircleAvatar(
          radius: 56.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 48.0,
            foregroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
            backgroundImage: NetworkImage(widget.defaultImageUrl),
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16.0,
                child: IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 20.0,
                    color: Color(0xFF404040),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
