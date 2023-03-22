import 'package:flutter/material.dart';

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
      home: LoginScreen(),
      theme: getDefaultTheme(),
    );
  }
}