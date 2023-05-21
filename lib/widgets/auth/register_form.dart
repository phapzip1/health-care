import 'dart:io';
import 'package:intl/intl.dart';

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
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = '';
    super.initState();
  }

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
      setState(() {
        _isLoading = true;
      });
      final isValid = widget.formkey.currentState!.validate();

      if (isValid) {
        widget.formkey.currentState?.save();
      }

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
          .child('${authResult.user!.uid}.jpg');

      await ref.putFile(File(_selectedImage!.path));

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('patient')
          .doc(authResult.user!.uid)
          .set({
        'patient_name': _enteredUsername,
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
              // Text(
              //   "Email",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(
                  hintText: "abc@gmail.com",
                  labelText: 'Email',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _enteredEmail = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@'))
                    return 'Please enter a valid email address';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //
              // Text(
              //   "Password",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              TextFormField(
                key: ValueKey('password'),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                obscureText: true,
                obscuringCharacter: "•",
                onChanged: (value) {
                  _enteredPassword = value.toString();
                },
              ),
              const SizedBox(height: 16),
              //
              // Text(
              //   "Retype-password",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Retype-password',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                obscureText: true,
                obscuringCharacter: "•",
              ),
              const SizedBox(height: 16),
              //
              // Text(
              //   "Name",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              TextFormField(
                key: ValueKey('username'),
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: 'Name',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onSaved: (value) {
                  _enteredUsername = value.toString();
                },
              ),
              const SizedBox(height: 16),
              //
              // Text(
              //   "Phone number",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "0123456789",
                  labelText: 'Phone number',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _enteredPhone = value.toString();
                },
              ),
              const SizedBox(height: 16),
              //
              // Text(
              //   "Gender",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
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
                onChanged: (value) {
                  _enteredGender = value == 0 ? 'Men' : 'Women';
                },
              ),
              const SizedBox(height: 16),
              //
              // Text(
              //   "Birthday",
              //   style: Theme.of(context).textTheme.displayMedium,
              // ),
              // const SizedBox(height: 8),
              TextFormField(
                controller: dateinput,
                decoration: InputDecoration(
                  hintText: "26/05/2002",
                  labelText: 'Birthday',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onTap: () async {
                  // prevent keyboard showing up
                  FocusScope.of(context).requestFocus(new FocusNode());

                  final result = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(1975, 1, 1),
                      lastDate: now);

                  if (result != null) {
                    String formattedDate = DateFormat('dd/MM/y').format(result);

                    _enteredBirthday = formattedDate;
                    setState(() {
                      dateinput.text = formattedDate;
                    });
                  }
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
                onPressed: _submit,
                child: const Text("Sign up"),
              ),
              const SizedBox(height: 10),

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
