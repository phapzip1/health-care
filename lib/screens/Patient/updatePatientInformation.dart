import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:intl/intl.dart';

class UpdatePatientInfo extends StatefulWidget {
  const UpdatePatientInfo({super.key});

  @override
  State<UpdatePatientInfo> createState() => _UpdatePatientInfoState();
}

class _UpdatePatientInfoState extends State<UpdatePatientInfo> {
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = '';
    super.initState();
  }

  var currentUrl;
  File? _selectedImage;

  var _enteredUsername = "";
  var _enteredPhone = "";
  Gender _enteredGender = Gender.male;
  DateTime _enteredBirthday = DateTime.now();

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

  var changed = 1;

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
            future: PatientModel.getById(user!.uid),
            builder: (ctx, futureSnapShot) {
              if (futureSnapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    circleAvatar(futureSnapShot.data!.image),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: TextEditingController(
                              text: futureSnapShot.data!.name),
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
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: TextEditingController(
                              text: futureSnapShot.data!.phoneNumber),
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
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8,
                        ),
                        DropDownTextField(
                          initialValue: futureSnapShot.data!.gender
                              .toString()
                              .substring(7),
                          clearOption: false,
                          dropDownItemCount: 2,
                          dropDownList: const [
                            DropDownValueModel(
                                name: 'male', value: Gender.male),
                            DropDownValueModel(
                                name: 'female', value: Gender.female),
                            DropDownValueModel(
                                name: 'other', value: Gender.other),
                          ],
                          textFieldDecoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                          ),
                          onChanged: (value) {
                            _enteredGender = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Birthday',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: changed != 1
                              ? dateinput
                              : TextEditingController(
                                  text: DateFormat('dd/MM/y')
                                      .format(futureSnapShot.data!.birthdate)),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                          ),
                          // onSaved: (value) {
                          //   _enteredBirthday = value.toString();
                          // },
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            final result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1975, 1, 1),
                                lastDate: DateTime.now());

                            if (result != null) {
                              DateTime formattedDate = result;

                              _enteredBirthday = formattedDate;
                              setState(() {
                                ++changed;
                                dateinput.text =
                                    DateFormat('dd/MM/y').format(formattedDate);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            }));
  }
}
