import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/gender_target_screen_controller.dart';
import 'package:dater/screens/authentication_screen/gender_target_screen/gender_target_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_appbar.dart';
import '../../../common_modules/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';

class GenderTargetScreen extends StatelessWidget {
  GenderTargetScreen({Key? key}) : super(key: key);
  final genderTargetScreenController = Get.put(GenderTargetScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,

      appBar: commonAppBarModule(
        text: AppMessages.targetGenderNotes,
        backGroundColor: Colors.transparent,
        iconColor: AppColors.darkOrangeColor,
        textFontFamily: FontFamilyText.sFProDisplayHeavy,
      ),

      //
      body: Obx(
        () => genderTargetScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GenderTargetRadioButtonModule(),
                    SizedBox(height: 6.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ButtonCustom(
                        text: AppMessages.genderNotes,
                        onPressed: () {},
                        size: const Size(50, 0),
                        fontWeight: FontWeight.bold,
                        textsize: 15,
                        textFontFamily: FontFamilyText.sFProDisplayHeavy,
                        textColor: AppColors.whiteColor2,
                        backgroundColor: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const GenderTargetNotesModule(),
                  ],
                ).commonSymmetricPadding(horizontal: 25, vertical: 10),
              ),
      ),

      bottomNavigationBar: ButtonCustom(
        text: "Next",
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textsize: 15,
        padding: EdgeInsets.symmetric(vertical: 5),
        backgroundColor: AppColors.darkOrangeColor,
        textColor: AppColors.whiteColor2,
        onPressed: () async =>
            await genderTargetScreenController.nextButtonFunction(),
      ).commonSymmetricPadding(horizontal: 20, vertical: 10),
    );
  }
}
