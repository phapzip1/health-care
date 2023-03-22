import 'package:flutter/material.dart';

import '../utils/formstage.dart';

class DoctorRegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final Function setFormStage;

  DoctorRegisterForm({required this.formkey, required this.setFormStage});

  @override
  Widget build(BuildContext context) {
  final now = DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Form(
        key: formkey,
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

                  final result = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(1975, 1, 1), lastDate: now);
                },
              ),
              const SizedBox(height: 16),
              //
              Text(
                "Expertise",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(hintText: "0123456789"),
                
              ),
              const SizedBox(height: 16),
              //
              ElevatedButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )
                  ),
                ),
                onPressed: () {},
                child: const Text("Sign up"),
              ),
              const SizedBox(height: 10),
              //
              Row(
                children: <Widget>[
                  const Text("Are you a patient?"),
                  TextButton(
                    onPressed: () =>setFormStage(FormStage.DoctorRegister),
                    child: const Text("Register for doctor"),
                  ),
                ],
              ),
              //
              Row(
                children: <Widget>[
                  const Text("Already has account?"),
                  TextButton(
                    onPressed: () => setFormStage(FormStage.Login),
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