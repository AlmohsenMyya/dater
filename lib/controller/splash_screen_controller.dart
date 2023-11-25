import 'dart:async';

import 'package:dater/constants/enums.dart';
import 'package:dater/screens/authentication_screen/login_screen/login_screen.dart';
import 'package:dater/screens/index_screen/index_bindeing.dart';
import 'package:dater/screens/index_screen/index_screen.dart';
import 'package:get/get.dart';

import '../utils/preferences/user_preference.dart';

class SplashScreenController extends GetxController {
  AuthAs authAs = AuthAs.login;

  UserPreference userPreference = UserPreference();

  startTimer() async {
    Timer(
      const Duration(milliseconds: 1500),
      () async {
        // Get User loggedIn or not
        // bool isUserLoggedIn = await userPreference.getUserLoggedInFromPrefs(
        //   key: UserPreference.isUserLoggedInKey,
        // );
        bool isCompleteRegister = await userPreference.getUserLoggedInFromPrefs(
          key: UserPreference.completeRegister,
        );
        if (isCompleteRegister == true) {
          Get.offAll(() => IndexScreen(), binding: IndexBinding());

          // Get.offAll(() => IndexScreen());
        } else {
          Get.off(() => LoginInScreen());
        }
      },
    );
  }

  @override
  void onInit() {
    startTimer();

    super.onInit();
  }
}
