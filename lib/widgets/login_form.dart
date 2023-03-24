import 'package:flutter/material.dart';
import '../utils/formstage.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormStage;
  bool forgot = false;

  final Map<String, dynamic> formData = {
    "Email": "",
    "Password": "",
  };

  LoginForm({required this.formKey, required this.setFormStage });
  
  void formSubmit() {
    forgot = false;
    final valid = formKey.currentState!.validate();
    if (valid) {
      // login 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
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
                if (forgot) 
                  return null;
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
                    bool isValid = formKey.currentState!.validate();
                    if (isValid) {
                      setFormStage(FormStage.OTP, email: formData["Email"]);
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
              onPressed: formSubmit,
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
                  onPressed: () => setFormStage(FormStage.PatientRegister),
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
