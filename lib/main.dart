import 'package:dater/screens/splash_screen/splash_screen.dart';
import 'package:dater/utils/notifction/notifcations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'utils/AppController.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

  await NotificationSetUp.init();
  Get.put(AppController(), permanent: true);
  ForegroundService().start();
}

serviceForGround() async {
  // UserPreference userPreference = UserPreference();
  // bool serviceForGroundRunning = await userPreference.getBoolFromPrefs(
  //     key: UserPreference.serviceForGroundRunning);
  // if (Platform.isAndroid && !serviceForGroundRunning) {
  //// if (Platform.isAndroid) {
  // ForegroundService().start();
  // ForegroundServiceNotification.setPriority(AndroidNotificationPriority.LOW);
  // userPreference.setBoolValueInPrefs(
  //     key: UserPreference.serviceForGroundRunning, value: true);
// }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: ThemeData(useMaterial3: false),
          debugShowCheckedModeBanner: false,
          title: 'Dating App',
          home: SplashScreen(),
        );
      },
    );
  }
}
