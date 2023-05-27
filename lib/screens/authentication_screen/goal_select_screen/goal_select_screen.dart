import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/controller/auth_screen_controllers/goal_select_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_appbar.dart';
import '../../../common_modules/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../constants/messages.dart';
import 'goal_select_screen_widgets.dart';

class GoalSelectScreen extends StatelessWidget {
  GoalSelectScreen({Key? key}) : super(key: key);
  final goalSelectScreenController = Get.put(GoalSelectScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.whatsyourgoal,
        backGroundColor: Colors.transparent,
        iconColor: AppColors.darkOrangeColor,
        textFontFamily: FontFamilyText.sFProDisplayHeavy,
      ),
      body: Obx(
        () => goalSelectScreenController.isLoading.value
            ? const CustomLoader()
            : SafeArea(
                child: Column(
                  children: [
                    GoalRadioButtonModule(),
                    SizedBox(height: 6.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ButtonCustom(
                        text: AppMessages.goalNotes,
                        onPressed: () {},
                        size: const Size(50, 0),
                        fontWeight: FontWeight.bold,
                        textsize: 15,
                        textFontFamily: FontFamilyText.sFProDisplayHeavy,
                        textColor: AppColors.whiteColor2,
                        backgroundColor: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    const GoalselectNotesModule(),
                  ],
                ).commonSymmetricPadding(horizontal: 25, vertical: 10),
              ),
      ),
      bottomNavigationBar: ButtonCustom(
        text: "Next",
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textsize: 15,
        backgroundColor: AppColors.darkOrangeColor,
        textColor: AppColors.whiteColor2,
        onPressed: () async => await goalSelectScreenController.nextButtonFunction(),
      ).commonSymmetricPadding(horizontal: 20, vertical: 10),
    );
  }
}
