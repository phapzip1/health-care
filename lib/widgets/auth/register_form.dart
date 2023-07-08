import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:health_care/widgets/user_image_picker.dart';
import '../../utils/formstage.dart';

import 'package:flutter/services.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final Function setFormStage;

  const RegisterForm(
      {super.key, required this.formkey, required this.setFormStage});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController dateinput = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

  File? _selectedImage;
  var _email = "";
  var _password = "";
  var _username = "";
  var _phone = "";
  var _gender = 0;
  DateTime _birthday = DateTime.now();

  void _submit(BuildContext context) async {
    try {
      final isValid = widget.formkey.currentState!.validate();
      if (_selectedImage == null) {
        return;
      }

      if (isValid) {
        widget.formkey.currentState?.save();
        context.read<AppBloc>().add(AppEventCreatePatientAccount(
            _selectedImage!,
            _email,
            _password,
            _username,
            _phone,
            _gender,
            _birthday));
      }
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
          physics: const BouncingScrollPhysics(),
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

              TextFormField(
                controller: _passwordController,
                key: const ValueKey('password'),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                obscureText: true,
                obscuringCharacter: "•",
                onSaved: (value) {
                  _password = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

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
                      (value != _passwordController.text && _passwordController.text != "")) {
                    return 'Please enter valid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                key: const ValueKey('username'),
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: 'Name',
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                ),
                onSaved: (value) {
                  _username = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter user name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

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
                  _gender = value;
                },
              ),
              const SizedBox(height: 16),

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
              Row(
                children: <Widget>[
                  const Text("Are you a doctor?"),
                  TextButton(
                    onPressed: () =>
                        widget.setFormStage(FormStage.DoctorRegister),
                    child: const Text("Register for doctor"),
                  ),
                ],
              ),
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
