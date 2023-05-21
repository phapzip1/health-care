import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdatePatientInfo extends StatefulWidget {
  const UpdatePatientInfo({super.key});

  @override
  State<UpdatePatientInfo> createState() => _UpdatePatientInfoState();
}

class _UpdatePatientInfoState extends State<UpdatePatientInfo> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  var currentUrl;
  File? _selectedImage;

  var _enteredUsername = "";
  var _enteredPhone = "";
  var _enteredGender = "";
  var _enteredBirthday = "";

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
  }

  circleAvatar(url) => SizedBox(
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: CircleAvatar(
            radius: 56.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              // ignore: sort_child_properties_last
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
                    )),
              ),
              radius: 48.0,
              foregroundImage:
                  _selectedImage != null ? FileImage(_selectedImage!) : null,
              backgroundImage: NetworkImage(url),
            ),
          ),
        ),
      );

  void _updateInfor() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState?.save();
    }

    if (_selectedImage != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${user!.uid}.jpg');

      await ref.putFile(File(_selectedImage!.path));

      currentUrl = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance
        .collection('patient')
        .doc(user!.uid)
        .update({
          'image_url': currentUrl,
          'patient_name': _enteredUsername,
          'phone_number': _enteredPhone,
          'gender': _enteredGender,
          'birthday': _enteredBirthday
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Update successfully'),
                backgroundColor: Colors.grey,
              ),
            ))
        .catchError((error) => print("Failed to update user: $error"));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Profile editing',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
                onPressed: _updateInfor,
                child: const Text(
                  'Save',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF3A86FF)),
                )),
          ],
        ),
        body: FutureBuilder(
            future: Future.value(user),
            builder: (ctx, futureSnapShot) {
              if (futureSnapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('patient')
                      .doc(user!.uid)
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) return Container();

                    final userDocs = snapshot.data!;

                    _enteredGender = userDocs['gender'];
                    currentUrl = userDocs['image_url'];

                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: [
                          circleAvatar(userDocs['image_url']),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Name',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: TextEditingController(
                                    text: userDocs['patient_name']),
                                style: const TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                ),
                                onSaved: (value) {
                                  _enteredUsername = value.toString();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Phone number',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: TextEditingController(
                                    text: userDocs['phone_number']),
                                style: const TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                ),
                                onSaved: (value) {
                                  _enteredPhone = value.toString();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Gender',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 8,
                              ),
                              DropDownTextField(
                                initialValue: userDocs['gender'].toString(),
                                clearOption: false,
                                dropDownItemCount: 2,
                                dropDownList: const [
                                  DropDownValueModel(name: 'Men', value: 'Men'),
                                  DropDownValueModel(
                                      name: 'Women', value: 'Women'),
                                ],
                                textFieldDecoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                ),
                                onChanged: (value) {
                                  _enteredGender = value.name.toString();
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Birthday',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: TextEditingController(
                                    text: userDocs['birthday']),
                                style: const TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                ),
                                onSaved: (value) {
                                  _enteredBirthday = value.toString();
                                },
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  });
            }));
  }
}
