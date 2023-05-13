import 'package:flutter/material.dart';
import 'package:health_care/utils/formstage.dart';
import '../../widgets/auth/opt_input.dart';

class OTPForm extends StatelessWidget {
  final String email;
  final Function setFormStage;

  OTPForm({required this.email, required this.setFormStage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "Confirm OTP code",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const Text("OTP code sent to "),
            Text(
              email,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 62),
        Form(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              OTPInput(true),
              OTPInput(false),
              OTPInput(false),
              OTPInput(false),
              OTPInput(false),
              OTPInput(false),
            ],
          ),
        ),
        const SizedBox(height: 62),
        // temporary
        ElevatedButton(
          onPressed: () {
            setFormStage(FormStage.ChangePassword);
          },
          child: const Text("Chuyển qua đổi pass, để tạm thời"),
        )
      ],
    );
  }
}
