import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_care/widgets/user_image_picker.dart';
import '../../utils/formstage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final Function setFormStage;
  const RegisterForm({required this.formkey, required this.setFormStage});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _auth = FirebaseAuth.instance;
  File? _selectedImage;
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _enteredUsername = "";
  var _enteredPhone = "";
  var _enteredGender = "";
  var _enteredBirthday = "";
  var _isLoading = false;

  void _submit() async {
    try {
      final isValid = widget.formkey.currentState!.validate();
      UserCredential authResult;

      if (!isValid || _selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please pick an image'),
            backgroundColor: Colors.grey,
          ),
        );
        return;
      }

      authResult = await _auth.createUserWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(authResult.user!.uid + '.jpg');

      await ref.putFile(File(_selectedImage!.path));

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'user_name': _enteredUsername,
        'email': _enteredEmail,
        'phone_number': _enteredPhone,
        'gender': _enteredGender,
        'birthday': _enteredBirthday,
        'image_url': url,
      });
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credential';
      if (err.message != null) {
        message = err.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Form(
        key: widget.formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Register",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              //
              UserImagePicker(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
              ),
              Text(
                "Email",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "abc@gmail.com"),
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Password",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
                obscuringCharacter: "•",
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Retype-password",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "Retype Password"),
                obscureText: true,
                obscuringCharacter: "•",
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "Enter your name"),
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Phone number",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "0123456789"),
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Gender",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: const InputDecoration(hintText: "Sex"),
                items: const <DropdownMenuItem<dynamic>>[
                  DropdownMenuItem(
                    value: 0,
                    child: Text("Men"),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text("Women"),
                  ),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Birthday",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "0123456789"),
                onTap: () async {
                  // prevent keyboard showing up
                  FocusScope.of(context).requestFocus(new FocusNode());

                  final result = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(1975, 1, 1),
                      lastDate: now);
                },
              ),
              const SizedBox(height: 16),
              //
              ElevatedButton(
                style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all<TextStyle>(const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  )),
                ),
                onPressed: () {},
                child: const Text("Sign up"),
              ),
              const SizedBox(height: 10),
              //
              // Row(
              //   children: <Widget>[
              //     const Text("Are you a doctor?"),
              //     TextButton(
              //       onPressed: () => widget.setFormStage(FormStage.DoctorRegister),
              //       child: const Text("Register for doctor"),
              //     ),
              //   ],
              // ),
              //
              Row(
                children: <Widget>[
                  const Text("Already has account?"),
                  TextButton(
                    onPressed: () => widget.setFormStage(FormStage.Login),
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
