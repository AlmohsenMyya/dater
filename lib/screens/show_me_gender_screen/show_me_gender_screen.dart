import 'package:dater/constants/messages.dart';
import 'package:dater/screens/show_me_gender_screen/show_me_gender_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/show_me_gender_controller.dart';

class ShowMeGenderScreen extends StatelessWidget {
  ShowMeGenderScreen({Key? key}) : super(key: key);
  final showMeGenderScreenController = Get.put(ShowMeGenderScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.showMe),
      bottomNavigationBar: ButtonCustom(
        text: "Done",
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textsize: 15,
        backgroundColor: AppColors.darkOrangeColor,
        textColor: AppColors.whiteColor2,
        onPressed: () async =>
            await showMeGenderScreenController.saveSexualityFunction(
          key: AppMessages.genderApiText,
          value: showMeGenderScreenController.selectedGenderValue.name,
        ),
      ).commonSymmetricPadding(horizontal: 20, vertical: 10),
      body: Obx(
        () => showMeGenderScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    GenderRadioButtonModule(),
                  ],
                ).commonSymmetricPadding(horizontal: 25, vertical: 10),
              ),
      ),
    );
  }
}
