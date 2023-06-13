import 'package:flutter/material.dart';

// screens
// import '../screens/page_not_found_screen.dart';
// import '../screens/call_screen.dart';
// import '../screens/Doctor/homePageDoctor.dart';
import '../screens/communityQA.dart';

class NavigationService {
  static bool isDoctor = false;
  static const String home = "/";
  static const String chat = "/chat";

  static final GlobalKey<NavigatorState> _navState = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navKey => _navState;

  static Route<dynamic> generateRoute(RouteSettings settings, Widget Function(BuildContext) homepageBuilder) {
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
      default:
        // return MaterialPageRoute(builder: (_) => PageNotFoundScreen(settings.name!));
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
