import 'package:dater/screens/set_up_email_screen/set_up_email_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/set_up_email_screen_controller.dart';

class SetUpEmailScreen extends StatelessWidget {
   SetUpEmailScreen({Key? key}) : super(key: key);
   final setUpEmailScreenController = Get.put(SetUpEmailScreenController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.setUpEmail),
      bottomNavigationBar: ButtonCustom(
        text: "Done",
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textsize: 15,
        backgroundColor: AppColors.darkOrangeColor,
        textColor: AppColors.whiteColor2,
        onPressed:  () async => await setUpEmailScreenController.continueButtonOnClickFunction(),
      ).commonSymmetricPadding(horizontal: 25, vertical: 10),
      body: Column(
        children: [
          SizedBox(height: 15.h,),
          SetUpEmailScreenWidgets(),
        ],
      ).commonSymmetricPadding(horizontal: 15),
    );
  }
}
