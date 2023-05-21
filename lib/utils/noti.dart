import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static const String _CHANNEL_ID = "guccinotification";
  static const String _CHANNEL_NAME = "Gucci_Notification";

  static Future<void> initialize() async {
    await FlutterLocalNotificationsPlugin().initialize(const InitializationSettings(
      android: AndroidInitializationSettings(
        "mipmap/ic_launcher",
      ),
      iOS: DarwinInitializationSettings(),
    ));
  }

  static Future<void> showCallNotification({
    int id = 0,
    required String title,
    required String body,
    dynamic payload,
    required FlutterLocalNotificationsPlugin plugin,
  }) async {
    const androidNotiDetails = AndroidNotificationDetails(
      _CHANNEL_ID,
      _CHANNEL_NAME,
      playSound: true,
      ongoing: true,
      importance: Importance.max,
      priority: Priority.max,
      category: AndroidNotificationCategory.call,
    );

    const iOSNotiDetails = DarwinNotificationDetails();
    await plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: androidNotiDetails,
        iOS: iOSNotiDetails,
      ),
    );
  }

  static Future<void> showGucci(FlutterLocalNotificationsPlugin plugin) async {
    const androidNotiDetails = AndroidNotificationDetails(
      _CHANNEL_ID,
      _CHANNEL_NAME,
      playSound: true,
      importance: Importance.max,
      priority: Priority.min,
    );

    const iOSNotiDetails = DarwinNotificationDetails();
    await plugin.show(
      1,
      "Gucci",
      "Gang Gang",
      const NotificationDetails(
        android: androidNotiDetails,
        iOS: iOSNotiDetails,
      ),
    );
  }
}
