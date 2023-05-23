import 'package:flutter/material.dart';
import 'package:health_care/widgets/auth/change_password_form.dart';
import '../widgets/auth/otp_form.dart';

// forms
import '../widgets/doctor_register_form.dart';
import '../widgets/auth/register_form.dart';
import '../widgets/auth/login_form.dart';

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
      body: SafeArea(
        child: Container(
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
                          child: Container(
                            width: 258,
                            height: dwidth/3.5,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFBDBDBD),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/logo_app.png",
                                        width: 32,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        'Health meeting',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    'Your health is our care',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          //
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
      ),
    );
  }
}
