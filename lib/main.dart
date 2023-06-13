import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health_care/screens/doctor_schedule_screen.dart';
import 'package:health_care/services/notification_service.dart';

import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

//screen import
import './screens/login_screen.dart';
import '../screens/page_not_found_screen.dart';
import './screens/loading_screen.dart';

//theme
import '../utils/app_theme.dart';

// service
import './services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.initialize(debug: true);
  NotificationService.startListeningNotificationEvents();
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
              return FutureBuilder(
                future: FirebaseFirestore.instance.collection("doc").doc(auth.data!.uid).get(),
                builder: (ctx2, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen("Loading...");
                  }
                   // if snapshot.hasData == true, then this is doctor vice versa 
                  return const PageNotFoundScreen("/undefined");
                },
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
