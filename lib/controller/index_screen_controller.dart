import 'dart:developer';

import 'package:dater/controller/balance_screen_controller.dart';
import 'package:dater/controller/chat_screen_controller.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_modules/custom_alertdialog.dart';
import '../constants/colors.dart';
import '../utils/preferences/user_preference.dart';
import 'all_chat_list_screen_controller.dart';

class IndexScreenController extends GetxController {
  var selectedIndex = 1.obs;

  final RxBool newMessages = false.obs;
  UserPreference userPreference = UserPreference();

  @override
  void onInit() async {
    BalanceScreenController balanceScreenController =
        Get.put(BalanceScreenController());
    String isFirstTime = await userPreference.getStringFromPrefs(
        key: UserPreference.isYourFirtsTime);
    if (isFirstTime == "yes") {
      balanceScreenController.setFCMTokenFunc();
    }
    // Initialization tasks can be performed here
    super.onInit();
  }

  // RxBool homeScreenShow = true.obs;
  changeIndex(int index) async {
    selectedIndex.value = index;
    String isFirstAd1Time = await userPreference.getStringFromPrefs(
        key: UserPreference.isYourAd1FirtsTime);
    String isFirstAd2Time = await userPreference.getStringFromPrefs(
        key: UserPreference.isYourAd2FirtsTime);
    String isFirstAd3Time = await userPreference.getStringFromPrefs(
        key: UserPreference.isYourAd3FirtsTime);
    print("$isFirstAd1Time*-*$isFirstAd2Time*-*$isFirstAd3Time");
    if (index == 0) {
      print("0000000000");
      BalanceScreenController balanceScreenController =
          Get.find<BalanceScreenController>();
      await balanceScreenController.getMyCoinsFunction();
      if (isFirstAd1Time != "no") {
        showSupportTreesByWalkingDialog();
        await userPreference.setStringValueInPrefs(
          key: UserPreference.isYourAd1FirtsTime,
          value: "no",
        );
      }

    } else if (index == 2) {
      print("2222222222");
      AllChatListScreenController chatScreenController =
          Get.put(AllChatListScreenController());
      newMessages.value = false;
      await chatScreenController.initMethod();
      if (isFirstAd2Time != "no") {
        showBeRespectfulKindDialog();
        await userPreference.setStringValueInPrefs(
          key: UserPreference.isYourAd2FirtsTime,
          value: "no",
        );
      }
    } else if (index == 3) {
      print("3333333333");
    } else if (index == 1) {
      if (isFirstAd3Time != "no") {
        showFindLoveFindFriendsDialog();
        await userPreference.setStringValueInPrefs(
          key: UserPreference.isYourAd3FirtsTime,
          value: "no",
        );
      }
      print("1111111111");
    }
  }

  showSupportTreesByWalkingDialog() async {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomAlertDialogWithoutRadioButton(
            text: 'Support Trees by Walking',
            content:
                ''' At Bambo, we believe in making a difference. As you go about your daily walks, earn virtual coins inside the app as a reward for your physical activity.

These coins can later be spent on premium services, allowing you to enhance your dating experience while contributing to the environment. It's a win-win situation!''',
            buttonText: 'Got it',
            value: "value",
            groupValue: "groupValue",
            onPressed: () {
              Get.back();
            },
            onChanged: (value) {
              log("value 111 : $value");
              // favoriteScreenController.isLoading(true);
              // if(favoriteScreenController.isShowAgain.value == "no") {
              //   favoriteScreenController.isShowAgain.value = "yes";
              // } else {
              //   favoriteScreenController.isShowAgain.value = "no";
              // }
              // // favoriteScreenController.isShowAgain.value = value!;
              // favoriteScreenController.isLoading(false);
              // log("value 222 : $value");
            },
            activeColor: AppColors.darkOrangeColor,
            // radioButtonText: "don't show again",
          );
        });
  }

  showBeRespectfulKindDialog() async {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomAlertDialogManyTitles(
            titles: [
              'Be respectful & kind',
              'Respect boundaries',
              'Unmatch or block & report'
            ],
            contents: [
              'Acknowledge and honor the limits others set',
              'Avoid any disrespectful behavior or language ',
              'If interactions become uncomfortable or inappropriate, you can end communication by unmatching or blocking the individual. Additionally, report any misconduct to the platform for review and action'
            ],
            value: 'someValue',
            groupValue: 'someGroupValue',
            onChanged: (value) {
              log("value 111 : $value");
              // favoriteScreenController.isLoading(true);
              // if(favoriteScreenController.isShowAgain.value == "no") {
              //   favoriteScreenController.isShowAgain.value = "yes";
              // } else {
              //   favoriteScreenController.isShowAgain.value = "no";
              // }
              // // favoriteScreenController.isShowAgain.value = value!;
              // favoriteScreenController.isLoading(false);
              // log("value 222 : $value");
            },
            activeColor: AppColors.darkOrangeColor,
            onPressed: () {
              Get.back();
            },
            buttonText: 'Got it ',
            // radioButtonText: "don't show again",
          );
        });
  }

  showFindLoveFindFriendsDialog() async {
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomAlertDialogWithoutRadioButton(
            text: 'Find love, find friends',
            content:
                ''' Your next great connection awaits!\n\n  When you swipe right, you'll spend virtual coins. No need to fret! Earn virtual coins within the app as a reward for your daily walks. ''',
            buttonText: 'Start swiping',
            value: "value",
            groupValue: "groupValue",
            onPressed: () {
              Get.back();
            },
            onChanged: (value) {
              log("value 111 : $value");
              // favoriteScreenController.isLoading(true);
              // if(favoriteScreenController.isShowAgain.value == "no") {
              //   favoriteScreenController.isShowAgain.value = "yes";
              // } else {
              //   favoriteScreenController.isShowAgain.value = "no";
              // }
              // // favoriteScreenController.isShowAgain.value = value!;
              // favoriteScreenController.isLoading(false);
              // log("value 222 : $value");
            },
            activeColor: AppColors.darkOrangeColor,
            // radioButtonText: "don't show again",
          );
        });
  }
}
