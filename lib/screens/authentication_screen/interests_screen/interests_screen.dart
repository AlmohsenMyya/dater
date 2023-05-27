import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/interests%20_screen_controller.dart';
import 'package:dater/screens/authentication_screen/interests_screen/interests_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InterestsScreen extends StatelessWidget {
  InterestsScreen({Key? key}) : super(key: key);
  final interestsScreenController = Get.put(InterestsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.whatsyourinterests,
        backGroundColor: Colors.transparent,
        iconColor: AppColors.darkOrangeColor,
        textFontFamily: FontFamilyText.sFProDisplayHeavy,
      ),
      body: Obx(
        ()=> interestsScreenController.isLoading.value
        ? const CustomLoader()
        : SafeArea(
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        AppMessages.chooseChatText,
                        style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                          textColor: AppColors.grey500Color,
                          fontSize: 14.sp
                        ),
                      ).commonSymmetricPadding(horizontal: 6.w),
                      // const SizedBox(height: 12),
                      Expanded(child: InterestsWidgetModule()),
                      // SizedBox(height: 3.h,),
                      // SportsWidgetsModule(),
                    ],
                  ).commonOnlyPadding(bottom: 10),
                ),
      ),
      bottomNavigationBar:  SkipAndNextButtonModule(),
    );
  }
}
