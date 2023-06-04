import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickImageFile;

  void _pickImage() async {
        final ImagePicker picker = ImagePicker();
    final option = await showDialog<int>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("Source"),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 1),
            child: const Text("Camera"),
          ),
          const SizedBox(
            height: 20,
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, 2),
            child: const Text("Gallery"),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );

    if (option == null) {
      return;
    }
    final XFile? image = await picker.pickImage(
        source: option == 1 ? ImageSource.camera : ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickImageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickImageFile != null ? FileImage(_pickImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
