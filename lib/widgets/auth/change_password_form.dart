import 'package:flutter/material.dart';
import 'package:health_care/utils/formstage.dart';

class ChangePasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormStage;
  final String email;

  final Map<String, dynamic> formdata = {
    "Password": "",
    "RePassword": ""
  };

  ChangePasswordForm({
    required this.formKey,
    required this.setFormStage,
    required this.email,
  });

  void _formSubmit() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      setFormStage(FormStage.Login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "New Password",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Row(
            children: [
              const Text(
                "You are using ",
              ),
              Text(
                email,
                style: const TextStyle(fontWeight: FontWeight.w700),
              )
            ],
          ),
          const SizedBox(height: 12),
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
              if (value == null || value.isEmpty) {
                return "Password must not be empty";
              }
              if (value.length < 8) {
                return "Password length must greater than or equal to 8";
              }
              return null;
            },
            onSaved: (value) {
              formdata["Password"] = value;
            },
          ),
          const SizedBox(height: 8),
          Text(
            "Enter a password",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(hintText: "Re-type Password"),
            obscureText: true,
            obscuringCharacter: "•",
            validator: (value) {
              if (formdata["Password"] as String != value) {
                return "Password does not match";
              }
              return null;
            },
            onSaved: (value) {
              formdata["RePassword"] = value;
            },
          ),
          const SizedBox(height: 16),
           ElevatedButton(
              onPressed: _formSubmit,
              child: const Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
