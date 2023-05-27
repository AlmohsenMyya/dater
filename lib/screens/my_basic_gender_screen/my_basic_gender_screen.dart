import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/my_basic_gender_screen_controller.dart';
import 'my_basic_gender_screen_widgets.dart';

class MyBasicGenderScreen extends StatelessWidget {
  MyBasicGenderScreen({Key? key}) : super(key: key);
  final myBasicGenderScreenController =
      Get.put(MyBasicGenderScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.gender),
      bottomNavigationBar: ButtonCustom(
        text: "Done",
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textsize: 15,
        backgroundColor: AppColors.darkOrangeColor,
        textColor: AppColors.whiteColor2,
        onPressed: () async =>
            await myBasicGenderScreenController.saveSexualityFunction(
              key: AppMessages.genderApiText,
              value: myBasicGenderScreenController.selectedSexualityValue.id,
            ),
      ).commonSymmetricPadding(horizontal: 20, vertical: 10),
      body: Obx(
        () => myBasicGenderScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    BasicGenderRadioButtonModule(),
                    SizedBox(height: 5.h),

                    SexualityShowModule(),

                  ],
                ).commonSymmetricPadding(horizontal: 25, vertical: 10),
              ),
      ),
    );
  }
}
