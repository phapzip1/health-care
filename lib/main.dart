import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_care/screens/Patient/mainPage.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

//screen import
import './screens/login_screen.dart';

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

  Widget _render(String collection, String uid, bool isDoctor) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collection)
            .doc(uid)
            .snapshots(),
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            return MainPage(isDoctor);
          }
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDefaultTheme(),
      navigatorKey: NavigationService.navKey,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) =>
          NavigationService.generateRoute(
        settings,
        (_) => StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext ctx, AsyncSnapshot<User?> auth) {
            if (auth.hasData) {
              final uid = FirebaseAuth.instance.currentUser!.uid; 

              if (NavigationService.isDoctor) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("doctor")
                      .doc(auth.data!.uid)
                      .snapshots(),
                  builder: (BuildContext ctx2,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          data) {
                    if (data.hasData) {
                      return _render('doctor', uid, true);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("patient")
                      .doc(auth.data!.uid)
                      .snapshots(),
                  builder: (BuildContext ctx2,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          data) {
                    if (data.hasData) {
                      return _render('patient', uid, false);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
