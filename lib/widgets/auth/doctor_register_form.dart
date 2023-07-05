// ignore_for_file: unused_field

import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/symptom_model.dart';
import 'package:health_care/widgets/user_image_picker.dart';
import 'package:intl/intl.dart';

import '../../utils/formstage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorRegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final Function setFormStage;

  DoctorRegisterForm({required this.formkey, required this.setFormStage});

  @override
  State<DoctorRegisterForm> createState() => _DoctorRegisterFormState();
}

class _DoctorRegisterFormState extends State<DoctorRegisterForm> {
  TextEditingController dateinput = TextEditingController();
  late List<SymptomModel> symptoms = [];
  @override
  void initState() {
    super.initState();
    dateinput.text = '';
    symptoms.addAll(context.read<AppBloc>().state.symptom!);
  }

  final _auth = FirebaseAuth.instance;
  File? _selectedImage;
  var _email = "";
  var _password = "";
  var _username = "";
  var _phone = "";
  var _exp = 0;
  var _price = 0;
  var _identityId = "";
  var _licenseId = "";
  var _workplace = "";
  var _specialization = "";
  var _gender = 0;

  DateTime _birthday = DateTime.now();

  void _submit(BuildContext context) async {
    try {
      final isValid = widget.formkey.currentState!.validate();

      if (isValid) {
        widget.formkey.currentState?.save();
      }

      if (!isValid || _selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please pick an image'),
            backgroundColor: Colors.grey,
          ),
        );
        return;
      }

      context.read<AppBloc>().add(AppEventCreateDoctorAccount(
            _email,
            _password,
            _selectedImage!,
            _username,
            _phone,
            _birthday,
            _exp,
            _price * 1.0,
            _identityId,
            _licenseId,
            _workplace,
            _specialization,
            _gender,
          ));
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.56,
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
              UserImagePicker(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
              ),
              TextFormField(
                key: const ValueKey('identity'),
                decoration: InputDecoration(
                  hintText: "...",
                  labelText: 'Identity Id',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  _identityId = value.toString();
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
                  _email = value.toString();
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
                onSaved: (value) {
                  _password = value.toString();
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
                      (value != _password && _password != null)) {
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
                  _username = value.toString();
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
                  _phone = value.toString();
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
                    value: 0,
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text("Female"),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text("Other"),
                  ),
                ],
                onChanged: (value) {
                  _gender = value as int;
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

                    _birthday = formattedDate;
                    // setState(() {
                    //   dateinput.text = DateFormat('dd/MM/y').format(formattedDate);
                    // });
                    dateinput.text =
                        DateFormat('dd/MM/y').format(formattedDate);
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
                  _licenseId = value.toString();
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
                  _workplace = value.toString();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter workplace';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              //

              DropDownTextField(
                dropDownList: symptoms.map((e) => DropDownValueModel(name: e.name, value: e.name)).toList(),
                onChanged: (value) {
                  _specialization = (value as DropDownValueModel).name;
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
                  _exp = int.parse(value!);
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
                  _price = int.parse(value!);
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
                onPressed: () => _submit(context),
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
