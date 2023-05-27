import 'dart:developer';

import 'package:dater/common_modules/custom_textfromfiled.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/sign_up_email_screen_controller.dart';
import 'package:dater/screens/authentication_screen/location_screen/location_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_button.dart';
import '../../../utils/field_validator.dart';
import '../../../utils/preferences/signup_preference.dart';
import '../../controller/set_up_email_screen_controller.dart';

class SetUpEmailScreenWidgets extends StatelessWidget {
  SetUpEmailScreenWidgets({super.key});
  final setUpEmailScreenController = Get.find<SetUpEmailScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10.5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteColor2,
            image: const DecorationImage(
              image: AssetImage(AppImages.locationImage),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          AppMessages.whatsYourEmail,
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            textColor: AppColors.grey800Color,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 2.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: AppMessages.donTLoseAccessToYourAccount,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey600Color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Form(
          key: setUpEmailScreenController.formKey,
          child: noShadowTextFormFiledCustom(
            fieldController: setUpEmailScreenController.emailTextFieldController,
            hintText: AppMessages.enterYourEmail,
            keyboardType: TextInputType.text,
            fillColor: AppColors.whiteColor2,
            validate: (value)=> FieldValidator().validateEmail(value!),
          ).commonSymmetricPadding(horizontal: 10),
        ),
        SizedBox(height: 2.h),

      ],
    );
  }
}
