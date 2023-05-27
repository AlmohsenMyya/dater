import 'package:dater/constants/font_family.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_button.dart';
import '../../../common_modules/custom_textfromfiled.dart';
import '../../../constants/colors.dart';
import '../../../constants/messages.dart';
import '../../../controller/auth_screen_controllers/user_name_screen_controller.dart';
import '../../../utils/field_validator.dart';
import '../../../utils/style.dart';

class SignUpNameScreenWidgets extends StatelessWidget {
  SignUpNameScreenWidgets({Key? key}) : super(key: key);
  final userNameScreenController = Get.find<UserNameScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            AppMessages.whatSYourName,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey800Color,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ]),
        SizedBox(height: 5.h),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            AppMessages.userName1,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey600Color,
              fontSize: 12.sp,
            ),
          ),
        ]),
        SizedBox(height: 2.6.h),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            AppMessages.userName2,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey600Color,
              fontSize: 12.sp,
            ),
          ),
        ]),
        SizedBox(height: 15.h),
        Form(
          key: userNameScreenController.formKey,
          child: noShadowTextFormFiledCustom(
            fieldController: userNameScreenController.nameTextFieldController,
            hintText: AppMessages.enterYourName,
            keyboardType: TextInputType.text,
            validate: (value) => FieldValidator().validateName(value!),
          ).commonSymmetricPadding(horizontal: 25),
        ),
        SizedBox(height: 2.h),
        ButtonCustom(
                backgroundColor: AppColors.darkOrangeColor,
                text: AppMessages.confirm,
                fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textColor: AppColors.gray50Color,
                onPressed: () async => await userNameScreenController.confirmButtonFunction(),
                shadowColor: AppColors.grey900Color)
            .commonSymmetricPadding(horizontal: 25),
      ],
    );
  }
}
