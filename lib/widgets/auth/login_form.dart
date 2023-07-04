// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import '../../utils/formstage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormStage;

  const LoginForm({super.key, required this.formKey, required this.setFormStage});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool forgot = false;

  final formData = {
    "email": "",
    "password": "",
  };

  void _formSubmit(BuildContext context) async {
    forgot = false;
    final valid = widget.formKey.currentState!.validate();

    if (valid) {
      context.read<AppBloc>().add(AppEventLogin(formData["email"]!, formData["password"]!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: widget.formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Your email address",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "abc@gmail.com"),
                validator: (value) {
                  final pattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value == null || value.isEmpty) {
                    return "Email field is required!";
                  }
                  if (!pattern.hasMatch(value)) {
                    return "Invalid Email";
                  }
                  return null;
                },
                onSaved: (value) {
                  formData["email"] = value!;
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Enter a password",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
                obscuringCharacter: "•",
                validator: (value) {
                  if (forgot) return null;
                  if (value == null || value.isEmpty) {
                    return "Password field is required!";
                  }

                  if (value.length <= 8) {
                    return "Password must be 8 characters or more";
                  }

                  return null;
                },
                onSaved: (value) {
                  formData["password"] = value!;
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      forgot = true;
                      bool isValid = widget.formKey.currentState!.validate();
                      if (isValid) {
                        widget.setFormStage(FormStage.OTP, email: formData["Email"]);
                      }
                    },
                    child: const Text(
                      "Forgot Password?",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _formSubmit(context),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Don't have an account yet?",
                    style: TextStyle(),
                  ),
                  TextButton(
                    onPressed: () => widget.setFormStage(FormStage.PatientRegister),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    child: const Text("Sign up"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
