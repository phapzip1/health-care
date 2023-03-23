import 'package:flutter/material.dart';
import './screens/Patient/mainPage.dart';


//screen import
import './screens/login_screen.dart';

//theme
import '../utils/app_theme.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: getDefaultTheme(),
      home: PatientMainPage(),
    );
  }
}