import 'package:flutter/material.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/screens/cards_and_wallets_screen.dart';
import 'package:health_care/screens/doctor_schedule_screen.dart';
import 'package:health_care/screens/payment_screen.dart';

// screens
// import '../screens/page_not_found_screen.dart';
import '../screens/call_screen.dart';
// import '../screens/Doctor/homePageDoctor.dart';
import '../screens/communityQA.dart';

class NavigationService {
  static bool isDoctor = false;
  static const String home = "/";
  static const String chat = "/chat";
  static const String schedule = "/schedule";
  static const String payment = "/payment";
  static const String wallets = "/wallets";

  static final GlobalKey<NavigatorState> _navState =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navKey => _navState;

  static Route<dynamic> generateRoute(
      RouteSettings settings, Widget Function(BuildContext) homepageBuilder) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: homepageBuilder);
      case chat:
        return MaterialPageRoute(builder: (_) => CommunityQA());
      case "/call":
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => CallScreen(
              token: data["token"],
              channelId: data["channel_id"],
              remotename: data["remote_name"],
              remotecover: data["remote_cover"],
              caller: data["caller"],
            ),
          );
        }
      case schedule:
        {
          final data = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => DoctorScheduleScreen(
              data,
            ),
          );
        }
      case payment:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => PaymentScreen(
              data["doctorId"],
              data["doctorName"],
              data["price"],
              data["doctorPhone"],
              data["doctorImage"],
              data["doctorSpecialization"],
              data["date"],
              data["hour"],
            ),
          );
        }
      case wallets:
        {
          final data = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => CardsAndWalletsScreen(
              data["doctorId"],
              data["doctorName"],
              data["price"],
              data["doctorPhone"],
              data["doctorImage"],
              data["doctorSpecialization"],
              data["date"],
              data["hour"],
              data["patient"],
            ),
          );
        }
      default:
        // return MaterialPageRoute(builder: (_) => PageNotFoundScreen(settings.name!));
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
