// import 'dart:isolate';
// import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:health_care/models/appointment_model.dart';

import '../firebase_options.dart';

import './navigation_service.dart';

class NotificationService {
  static const int _call_id = 1;
  static const int _missed_call_id = 2;

  static Future<void> initialize({required bool debug}) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
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
    final payload = receivedAction.payload!;
    if (payload["action"] == "call") {
      if (receivedAction.actionType == ActionType.Default) {
        NavigationService.navKey.currentState?.pushNamedAndRemoveUntil('/call', (route) => (route.settings.name != '/call') || route.isFirst, arguments: {
          "token": payload["token"],
          "channel_id": payload["channel_id"],
          "remote_name": payload["name"],
          "remote_cover": payload["cover"],
          "caller": false,
        });
      } else if (receivedAction.actionType == ActionType.SilentAction) {
        AppointmentModel.getById(payload["channel_id"]!).then((value) => value.declineCall());
      }
    }
  }

  // static Future<void> executeLongTaskInBackground() async {
  //   print("starting long task");
  //   await Future.delayed(const Duration(seconds: 4));
  //   final url = Uri.parse("http://google.com");
  //   print("long task done");
  // }

  // static Future<void> onSilentActionHandle(ReceivedAction received) async {
  //   print('On new background action received: ${received.toMap()}');

  //   SendPort? uiSendPort = IsolateNameServer.lookupPortByName('background_notification_action');
  //   if (uiSendPort != null) {
  //     print('Background action running on parallel isolate without valid context. Redirecting execution');
  //     uiSendPort.send(received);
  //     return;
  //   }

  //   print('Background action running on main isolate');
  //   await _handleBackgroundAction(received);
  // }

  // static Future<void> _handleBackgroundAction(ReceivedAction received) async {
  //   // Your background action handle
  // }

  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    final data = silentData.data!;
    if (data["action"] == "call") {
      sendCallNotification(
        id: data["caller_id"]!,
        name: data["caller_name"]!,
        ava: data["caller_ava"]!,
        room: data["room"]!,
        token: data["token"]!,
      );
    } else if (data["action"] == "cancel") {
      AwesomeNotifications().dismiss(_call_id);
      sendMissedCallNotification(
        doctorName: data["doctor"]!,
      );
    } else if (data["action"] == "decline") {
      final sendPort = IsolateNameServer.lookupPortByName("background_notification_action");
      sendPort?.send(null);
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
    final notificationContent = NotificationContent(
      id: _call_id,
      channelKey: "call",
      body: "Incoming Call",
      category: NotificationCategory.Call,
      actionType: ActionType.Default,
      payload: {
        "action": "call",
        "id": id,
        "name": name,
        "cover": ava,
        "channel_id": room,
        "token": token,
      },
      autoDismissible: true,
    );
    AwesomeNotifications().createNotification(content: notificationContent, actionButtons: [
      NotificationActionButton(key: "answer", label: "Answer", color: Colors.green, actionType: ActionType.Default),
      NotificationActionButton(
        key: "decline",
        label: "Decline",
        color: Colors.red,
        actionType: ActionType.SilentAction,
      ),
    ]);
  }

  static Future<bool> sendMissedCallNotification({
    required String doctorName,
  }) async {
    final res = await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _missed_call_id,
        channelKey: "call",
        title: "Missed call",
        body: "You have missed call with $doctorName",
        category: NotificationCategory.MissedCall,
      ),
    );
    return res;
  }
}
