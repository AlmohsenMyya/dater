import 'package:dater/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'utils/AppController.dart';

Future<void> main() async {
  runApp(const MyApp());
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
          debugShowCheckedModeBanner: false,
          title: 'Dating App',
          home: SplashScreen(),
        );
      },
    );
  }
}
