import 'package:dater/screens/verify_your_account_screen/verify_your_account_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/auth_screen_controllers/verify_your_account_screen_controller.dart';
class VerifyYourAccountScreen extends StatelessWidget {
   VerifyYourAccountScreen({Key? key}) : super(key: key);
   final verifyYourAccountScreenController = Get.put(VerifyYourAccountScreenController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.verifyYourAccount),


      body: Column(
        children: [
          SizedBox(height: 3.h,),
           ImageSelectModule(),
          SizedBox(height: 6.h,),
          const VerifyAccountTextModule(),
        ],
      ),

      bottomNavigationBar: ButtonCustom(
        text: AppMessages.done,
        shadowColor: AppColors.grey900Color,
        onPressed: () async => await verifyYourAccountScreenController.doneButtonFunction(),
        fontWeight: FontWeight.bold,
        textsize: 14.sp,
        textFontFamily: FontFamilyText.sFProDisplayBold,
        textColor: AppColors.whiteColor2,
        backgroundColor: AppColors.darkOrangeColor,
      ).commonSymmetricPadding(vertical: 20,horizontal: 25),


    );
  }
}
