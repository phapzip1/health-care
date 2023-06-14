// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../utils/formstage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_storage/firebase_storage.dart';

class DoctorRegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final Function setFormStage;

  DoctorRegisterForm({required this.formkey, required this.setFormStage});

  @override
  State<DoctorRegisterForm> createState() => _DoctorRegisterFormState();
}

class _DoctorRegisterFormState extends State<DoctorRegisterForm> {
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
  var _enteredExp = 0;
  var _enteredPrice = 0;
  var _enteredIdentityId = "";
  var _enteredLicenseId = "";
  var _enteredWorkplace = "";
  var _enteredSpecialization = "";
  Gender _enteredGender = Gender.male;
  DateTime _enteredBirthday = DateTime.now();
  final now = DateTime.now();

  void _submit() async {
    try {
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

      final ref_img = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${authResult.user!.uid}.jpg');

      await ref_img.putFile(File(_selectedImage!.path));

      final url = await ref_img.getDownloadURL();

      final user = DoctorModel(
          authResult.user!.uid,
          _enteredUsername,
          _enteredPhone,
          _enteredGender,
          _enteredBirthday,
          _enteredEmail,
          _enteredExp,
          _enteredPrice,
          _enteredWorkplace,
          _enteredSpecialization,
          _enteredIdentityId,
          _enteredLicenseId,
          url);

      await user
          .save()
          .onError((error, stackTrace) => Fluttertoast.showToast(
                msg: "Register unsuccessfully!",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              ))
          .whenComplete(() => Fluttertoast.showToast(
                msg: "Register successfully!",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.greenAccent,
                textColor: Colors.black,
                fontSize: 16.0,
              ));
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credential';

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      if (err.message != null) {
        message = err.message.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      Fluttertoast.showToast(
        msg: "Register unsuccessfully!",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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

              TextFormField(
                key: const ValueKey('identity'),
                decoration: InputDecoration(
                  hintText: "...",
                  labelText: 'Identity Id',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _enteredIdentityId = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your identity id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                key: const ValueKey('email'),
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
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                key: const ValueKey('password'),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                obscureText: true,
                obscuringCharacter: "•",
                onChanged: (value) {
                  _enteredPassword = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Retype-password',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                obscureText: true,
                obscuringCharacter: "•",
                validator: (value) {
                  if (value!.isEmpty ||
                      // ignore: unnecessary_null_comparison
                      (value != _enteredPassword && _enteredPassword != null)) {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                key: const ValueKey('username'),
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: 'Name',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onSaved: (value) {
                  _enteredUsername = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter user name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
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
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                items: const <DropdownMenuItem<dynamic>>[
                  DropdownMenuItem(
                    value: Gender.male,
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: Gender.female,
                    child: Text("Female"),
                  ),
                  DropdownMenuItem(
                    value: Gender.other,
                    child: Text("Other"),
                  ),
                ],
                onChanged: (value) {
                  _enteredGender = value;
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                controller: dateinput,
                decoration: InputDecoration(
                  hintText: "26/05/2002",
                  labelText: 'Birthday',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onTap: () async {
                  // prevent keyboard showing up
                  FocusScope.of(context).requestFocus(FocusNode());

                  final result = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(1975, 1, 1),
                      lastDate: now);

                  if (result != null) {
                    DateTime formattedDate = result;

                    _enteredBirthday = formattedDate;
                    setState(() {
                      dateinput.text =
                          DateFormat('dd/MM/y').format(formattedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                key: const ValueKey('license'),
                decoration: InputDecoration(
                  labelText: 'Your license id',
                  hintText: "...",
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onSaved: (value) {
                  _enteredLicenseId = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your license id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //
              TextFormField(
                key: const ValueKey('workplace'),
                decoration: InputDecoration(
                  hintText: "...",
                  labelText: 'Workplace',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onSaved: (value) {
                  _enteredWorkplace = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter expertise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //

              TextFormField(
                key: const ValueKey('specialization'),
                decoration: InputDecoration(
                  hintText: "Dermatology...",
                  labelText: 'Expertise',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onSaved: (value) {
                  _enteredSpecialization = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter expertise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //

              TextFormField(
                key: const ValueKey('experience'),
                decoration: InputDecoration(
                  hintText: "...",
                  labelText: 'Experience',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _enteredExp = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your experience';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //

              TextFormField(
                key: const ValueKey('price'),
                decoration: InputDecoration(
                  hintText: "...",
                  labelText: 'Price for consultant',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _enteredPrice = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your price';
                  }
                  return null;
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
              //
              Row(
                children: <Widget>[
                  const Text("Are you a patient?"),
                  TextButton(
                    onPressed: () =>
                        widget.setFormStage(FormStage.PatientRegister),
                    child: const Text("Register for patient"),
                  ),
                ],
              ),
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
