import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/enums.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/verification_code_screen_controller.dart';
import 'package:dater/screens/authentication_screen/verify_code_screen/verify_code_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/font_family.dart';
import '../../../utils/style.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key});
  final verifyCodeScreenController = Get.put(VerifyCodeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.myCodeIs),

      // .commonSymmetricPadding(horizontal: 25, vertical: 30),
      body: Column(
        children: [
          SizedBox(height: 2.h),
          VerificationCodeFieldModule(),

          SizedBox(height: 5.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Please enter the 4-digit code sent to you at ",
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    fontSize: 17,
                    textColor: AppColors.grey600Color,
                  ),
                ),
                TextSpan(
                  text:
                  // "${verifyCodeScreenController.countryCode}"
                      " ${verifyCodeScreenController.mobileNumber}",
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayBold,
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ).commonSymmetricPadding(horizontal: 13.w),
          SizedBox(height: 5.h),

          // SizedBox(height: 13.h),
          ResendButtonModule(),
          const Spacer(),
          KeyBoardeCustomModule()
        ],
      ).commonSymmetricPadding(horizontal: 10),


      bottomNavigationBar: ButtonCustom(
          backgroundColor: AppColors.darkOrangeColor,
          text: AppMessages.submit,
          fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textColor: AppColors.gray50Color,
          onPressed: () async {

            if(verifyCodeScreenController.controller.text.length == 4) {
              await verifyCodeScreenController.activateAccountFunction();
            } else {
              Fluttertoast.showToast(msg: AppMessages.enterValidCode);
            }


          },
          shadowColor: AppColors.grey900Color)
          .commonOnlyPadding(left: 25, right: 25, bottom: 30),
    );
  }
}
