import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qas/data/local/prefs.dart';

import '../firebase_options.dart';
import '../main.dart';

class PushNotifications {
  // function to listen to background changes
  static Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("Some notification Received in background...");
    }
  }

  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // request notification permission
  static Future init() async {
    var option = DefaultFirebaseOptions.currentPlatform;
    await Firebase.initializeApp(options: option);
    await requestPermissions();
    // get the fcm device token
    await getDeviceToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
    // initialize local notifications
    localNotificationInit();
    // to handle foreground notifications
    onMessage();
    // on background notification tapped
    onMessageOpenedApp();
    remoteMessage();
  }

  static Future getDeviceToken({int maxRetires = 3}) async {
    try {
      String? token;
      if (kIsWeb) {
        token = await _firebaseMessaging.getToken(
            vapidKey:
                "BKY3XWsf2elEp-M60u29TEh-8mB4sEKnFf0VCD8X3OjfR_FmGZHcuE2yL_K0B5FERyYOXnzrnfOGIWFOg9sQlug");
      } else {
        token = await _firebaseMessaging.getToken();
      }
      SharedPrefs.saveFCMToken(token ?? "");
      print("service : "+token!);
      return token;
    } catch (e) {
      if (maxRetires > 0) {
        await Future.delayed(const Duration(seconds: 10));
        return getDeviceToken(maxRetires: maxRetires - 1);
      } else {
        return null;
      }
    }
  }

  // initialize local notifications
  static Future localNotificationInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    // request notification permissions for android 13 or above
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    print(notificationResponse.payload);
    navigatorKey.currentState
        ?.pushReplacementNamed("/", arguments: notificationResponse);
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print(message.data);
        navigatorKey.currentState
            ?.pushReplacementNamed("/", arguments: message);
      }
    });
  }

  static void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);

      if (message.notification != null) {
        if (kIsWeb) {
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!);
        } else {
          showSimpleNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              payload: payloadData);
        }
      }
    });
  }

  // to handle notification on foreground on web platform
  static void showNotification({required String title, required String body}) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"))
        ],
      ),
    );
  }

  static void remoteMessage() async {
    // for handling in terminated state
    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      Future.delayed(const Duration(seconds: 1), () {
        print(message.data);
        navigatorKey.currentState!.pushNamed("/", arguments: message);
      });
    }
  }

  static Future requestPermissions() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
  }
}
