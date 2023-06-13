import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

import './navigation_service.dart';

class NotificationService {
  static const int _call_id = -1;

  static Future<void> initialize({required bool debug}) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.red,
          ledColor: Colors.red,
        ),
        NotificationChannel(
          channelKey: "call",
          channelName: "Call",
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.blueAccent,
          ledColor: Colors.blueAccent,
        ),
      ],
      debug: debug,
    );
    await AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: mySilentDataHandle,
      onFcmTokenHandle: myFcmTokenHandle,
      onNativeTokenHandle: myNativeTokenHandle,
      licenseKeys: null,
      debug: debug,
    );
    debugPrint("Token ${await getFirebaseMessagingToken()}");
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  static Future<void> getInitialNotificationAction() async {
    ReceivedAction? receivedAction = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: true);
    if (receivedAction == null) return;
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint("BACKGROUND");
    final payload = receivedAction.payload!;
    NavigationService.navKey.currentState?.pushNamedAndRemoveUntil('/call', (route) => (route.settings.name != '/call') || route.isFirst, arguments: {
      "token": payload["token"],
      "channel_id": payload["channel_id"],
      "remote_name": payload["name"],
      "remote_cover": payload["cover"],
      "caller": false,
    });
  }

  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    debugPrint('"SilentData": ${silentData.toString()}');
    final data = silentData.data!;
    if (data["action"] == "call") {
      sendCallNotification(
        id: data["caller_id"]!,
        name: data["caller_name"]!,
        ava: data["caller_ava"]!,
        room: data["room"]!,
        token: data["token"]!,
      );
    }
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('Firebase Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
  }

  // Request FCM token to Firebase
  static Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (exception) {
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }

  static Future<void> sendCallNotification({
    required String id,
    required String name,
    required String ava,
    required String room,
    required String token,
  }) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(id: _call_id, channelKey: "call", body: "Incoming Call", category: NotificationCategory.Call, payload: {
        "id": id,
        "name": name,
        "cover": ava,
        "channel_id": room,
        "token": token,
      }),
    );
  }
}
