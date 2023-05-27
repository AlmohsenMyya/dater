import 'package:dater/controller/looking_for_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import 'looking_for_screen_widgets.dart';

class LookingForScreen extends StatelessWidget {
  LookingForScreen({super.key});
  final lookingForScreenController = Get.put(LookingForScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.lookingFor),

      bottomNavigationBar: ButtonCustom(
        text: "Done",
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textsize: 15,
        backgroundColor: AppColors.darkOrangeColor,
        textColor: AppColors.whiteColor2,
        onPressed: () async => await lookingForScreenController.doneButtonFunction(),
      ).commonSymmetricPadding(horizontal: 20, vertical: 10),


      body: Obx(
        () => lookingForScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    LookingForRadioButtonModule(),
                  ],
                ),
              ).commonSymmetricPadding(horizontal: 25, vertical: 10),
      ),
    );
  }
}
