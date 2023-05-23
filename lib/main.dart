import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_care/screens/payment_screen.dart';
import './screens/Patient/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

//screen import
import './screens/login_screen.dart';

//theme
import '../utils/app_theme.dart';

// local notification
import './utils/noti.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // head up
  if (message.data["type"] == "incoming") {
    Noti.showCallNotification(title: "Bac si goi", body: message.notification!.title!, plugin: FlutterLocalNotificationsPlugin());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Noti.initialize();
  // head up message
  FirebaseMessaging.onMessage.listen((message) {
    if (message.data["type"] == "incoming") {
      Noti.showCallNotification(title: "Bac si goi", body: message.notification!.title!, plugin: FlutterLocalNotificationsPlugin());
    }
  });
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getDefaultTheme(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.hasData) {
            return PatientMainPage();
            // return PaymentScreen();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
