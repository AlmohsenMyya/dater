import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class NotificationSetUp {
  static init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken() ;
    print('JHBB54545 $fcmToken');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', fcmToken??"null problem");
    if (
    Platform.isIOS
    ) {
      messaging.requestPermission(
          badge: true, alert: true, sound: true, announcement: true);
    }
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    messaging.subscribeToTopic("gogehs");
    await _setUpNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                "gogesh",
                "High Importance Notifications",
                icon: android.smallIcon,
              ),
            ));
      } else if (notification != null && apple != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                iOS: DarwinNotificationDetails(
                    presentAlert: true,
                    subtitle: notification.title,
                    badgeNumber: 1,
                    presentSound: true,
                    presentBanner: true,
                    presentList: true,
                    presentBadge: true)));
      }
    });
  }

  static _setUpNotifications() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'gogesh', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
