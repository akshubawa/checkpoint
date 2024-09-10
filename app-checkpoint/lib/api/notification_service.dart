import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> initializeNotification() async {
    String? deviceToken = await firebaseMessaging.getToken();
    String? deviceApnsToken = await firebaseMessaging.getAPNSToken();
    debugPrint(deviceToken);
    debugPrint(deviceApnsToken);

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );

    await AwesomeNotifications().initialize(
      null,
      [
        
        NotificationChannel(
          channelKey: 'notification_channel',
          channelName: 'Notification Channel',
          channelDescription: "Channel of informative Notification",
          defaultColor: Colors.redAccent,
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          onlyAlertOnce: false,
          playSound: true,
          criticalAlerts: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          // soundSource: "assets/ringtone/emergency_alert.mp3"
        ),
      ],
      debug: true,
    );

    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage: ${message.data}");
      showNotification(message: message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: ${message.data}");
    });

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @pragma("vm:entry-point")
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");

    final notification = message.notification; // Get notification object
  final data = message.data;

  String? title = notification?.title; // Extract title
  String? body = notification?.body; // Extract body
    print("DATA: $data");
    Map<String, String> payloadMap = Map<String, String>.from(data);
    log("payloadMap: $payloadMap");

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: "notification_channel",
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
          category: NotificationCategory.Promo,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          actionType: ActionType.Default,
          payload: payloadMap,
          backgroundColor: Colors.orange,
          // largeIcon: data["image"]! ?? ""
        ),
      );

    // if (data["type"] == "message") {
    //   await AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 0,
    //       channelKey: "notification_channel",
    //       title: data["title"]! ?? "You received a message",
    //       body: data["body"],
    //       notificationLayout: NotificationLayout.Messaging,
    //       category: NotificationCategory.Message,
    //       wakeUpScreen: true,
    //       fullScreenIntent: true,
    //       autoDismissible: false,
    //       backgroundColor: Colors.orange,
    //       largeIcon: data["image"] ?? "",
    //     ),
    //     actionButtons: [
    //       NotificationActionButton(
    //         key: "READ",
    //         label: "Mark as Read",
    //         color: Colors.green,
    //         enabled: true,
    //         autoDismissible: true,
    //       ),
    //     ],
    //   );
    // }
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("Action received: ${receivedAction.buttonKeyPressed}");
    if (receivedAction.buttonKeyPressed == "ACCEPT") {
      // Map<String, String?>? payload = receivedAction.payload;
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print(receivedNotification.body);
    debugPrint("Notification received: ${receivedNotification.id}");
    // Handle the notification here
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print(receivedNotification.body);
    debugPrint("Notification displayed: ${receivedNotification.id}");
    // Handle the displayed notification here
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("Notification dismissed: $receivedAction");
    print(receivedAction);

    // Handle the dismissed notification here
  }

  static Future<void> showNotification({
    required final RemoteMessage message,
  }) async {
    final notification = message.notification; // Get notification object
  final data = message.data;

  String? title = notification?.title; // Extract title
  String? body = notification?.body; // Extract body
    Map<String, String> payloadMap = Map<String, String>.from(data);

    print("########################");
    print(title);
    print("########################");

    log("payloadMap: $payloadMap");

    // if (data["type"] == "call") {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: "notification_channel",
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default,
          category: NotificationCategory.Promo,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          actionType: ActionType.Default,
          payload: payloadMap,
          backgroundColor: Colors.orange,
          // largeIcon: data["image"]! ?? ""
        ),
      );
    // } else if (data["type"] == "message") {
    //   await AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //       id: 0,
    //       channelKey: "notification_channel",
    //       title: data["title"]! ?? "You received a message",
    //       body: data["body"],
    //       notificationLayout: NotificationLayout.Messaging,
    //       category: NotificationCategory.Message,
    //       wakeUpScreen: true,
    //       fullScreenIntent: true,
    //       autoDismissible: false,
    //       backgroundColor: Colors.orange,
    //       largeIcon: data["image"] ?? "",
    //     ),
    //     actionButtons: [
    //       NotificationActionButton(
    //         key: "READ",
    //         label: "Mark as Read",
    //         color: Colors.green,
    //         enabled: true,
    //         autoDismissible: true,
    //       ),
    //     ],
    //   );
    // }
  }
}
