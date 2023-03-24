import 'package:flutter/material.dart';
import 'package:health_care/widgets/change_password_form.dart';
import 'package:health_care/widgets/otp_form.dart';

// forms
import '../widgets/doctor_register_form.dart';
import '../widgets/register_form.dart';
import '../widgets/login_form.dart';

// utils
import '../utils/formstage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FormStage stage = FormStage.Login;
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  final _doctorRegisterFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  String _email = "";

  void updateFormStage(FormStage stage, {String email = ""}) {
    if (this.stage != stage) {
      if (stage == FormStage.OTP) {
        setState(() {
          _email = email;
        });
      }
      setState(() {
        this.stage = stage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/images/loginwallpaper.webp",
                width: 20,
                height: 20,
                repeat: ImageRepeat.repeat,
              ),
            ),
            Positioned.fill(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: dwidth / 2,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black, blurRadius: 4.0),
                        ],
                      ),
                      child: AnimatedSize(
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 200),
                          child: stage == FormStage.Login
                              ? LoginForm(
                                  formKey: _loginFormKey,
                                  setFormStage: updateFormStage)
                              : stage == FormStage.PatientRegister
                                  ? RegisterForm(
                                      formkey: _registerFormKey,
                                      setFormStage: updateFormStage)
                                  : stage == FormStage.DoctorRegister
                                      ? DoctorRegisterForm(
                                          formkey: _doctorRegisterFormKey,
                                          setFormStage: updateFormStage,
                                        )
                                      : stage == FormStage.ChangePassword
                                          ? ChangePasswordForm(
                                              formKey: _changePasswordFormKey,
                                              setFormStage: updateFormStage,
                                              email: _email)
                                          : OTPForm(
                                              email: _email,
                                              setFormStage: updateFormStage)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
