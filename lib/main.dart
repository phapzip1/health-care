import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

//screen import
import './screens/login_screen.dart';
import './screens/doctor_schedule_screen.dart';

//theme
import '../utils/app_theme.dart';

// service
import './services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyWidget(),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDefaultTheme(),
      navigatorKey: NavigationService.navKey,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) => NavigationService.generateRoute(
        settings,
        (_) => StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext ctx, AsyncSnapshot<User?> auth) {
            if (auth.hasData) {
              if (NavigationService.isDoctor) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("doctor").doc(auth.data!.uid).snapshots(),
                  builder: (BuildContext ctx2, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> data) {
                    if (data.hasData) {
                    }
                    return ;
                  },
                );
              } else {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("patient").doc(auth.data!.uid).snapshots(),
                  builder: (BuildContext ctx2, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> data) {
                    if (data.hasData) {

                    }
                  },
                );
              }
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
