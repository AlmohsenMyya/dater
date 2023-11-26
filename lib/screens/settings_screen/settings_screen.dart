import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:get/get.dart';
import '../../controller/settings_screen_controller.dart';
import 'settings_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../constants/messages.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final settingsScreenController = Get.put(SettingsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.settings),
      body: Obx(
        () => settingsScreenController.isLoading.value
            ? const CustomLoader()
            : SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: 4.h),
                      ReferralNumberModule(),
                      SizedBox(height: 4.h),
                      VerifyAccountModule(),
                      SizedBox(height: 2.h),
                      const PersonalInfoModule(),
                      SizedBox(height: 3.h),
                      const LocationModule(),
                      SizedBox(height: 3.h),
                      // ShowMeModule(),
                      // SizedBox(height: 3.h),
                      const CookiePolicyModule(),
                      SizedBox(height: 3.5.h),
                      const TermsOfYouUseModule(),
                      SizedBox(height: 3.5.h),
                      const PrivacyPolicyModule(),
                      SizedBox(height: 3.5.h),
                      BothButtonModule(),
                      SizedBox(height: 4.h),
                    ],
                  ).commonSymmetricPadding(horizontal: 30),
                ),
              ),
      ),
    );
  }
}
