import 'package:flutter/material.dart';
import '../../utils/formstage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormStage;

  LoginForm({required this.formKey, required this.setFormStage});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool forgot = false;
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  final Map<String, dynamic> formData = {
    "Email": "",
    "Password": "",
  };

  void _formSubmit() async {
    forgot = false;
    final valid = widget.formKey.currentState!.validate();

    if (valid) {
      try {
        setState(() {
          _isLoading = true;
        });
        UserCredential authResult;
        authResult = await _auth.signInWithEmailAndPassword(
            email: formData['Email'], password: formData['Password']);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: widget.formKey,
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
                final pattern = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                if (value == null || value.isEmpty) {
                  return "Email field is required!";
                }
                if (!pattern.hasMatch(value)) {
                  return "Invalid Email";
                }
                return null;
              },
              onChanged: (value) {
                formData["Email"] = value;
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
              onChanged: (value) {
                formData["Password"] = value;
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
                      widget.setFormStage(FormStage.OTP,
                          email: formData["Email"]);
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
              onPressed: _formSubmit,
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
                  onPressed: () =>
                      widget.setFormStage(FormStage.PatientRegister),
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
    );
  }
}
