import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/font_family.dart';
import '../utils/style.dart';
import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  String text;
  String content;
  String value;
  String groupValue;
  String buttonText;
  Function() onPressed;
  String radioButtonText;
  Function(String?)? onChanged;
  Color? activeColor;
  EdgeInsetsGeometry? titlePadding;
  EdgeInsetsGeometry? contentPadding;
  CustomAlertDialog({
    Key? key,
    required this.text,
    required this.content,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.onPressed,
    required this.buttonText,
    required this.activeColor,
    required this.radioButtonText,
    this.titlePadding,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      titlePadding: titlePadding,
      title: Text(
        text,
        style: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayBold,
          textColor: AppColors.blackColor,
          fontSize: 14.sp,
          // fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: contentPadding,
      content: Text(
        content,
        style: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.grey600Color,
          fontSize: 14.sp,
          // fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        const Divider(thickness: 2),
        ButtonCustom(
          text: buttonText,
          onPressed: onPressed,
          // fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayBold,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.darkOrangeColor,
        ).commonSymmetricPadding(horizontal: 35),
        Row(children: [
          // Checkbox(
          //     value: isShowAgain.value,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(25),
          //     ),
          //     activeColor: AppColors.darkOrangeColor,
          //     checkColor: AppColors.darkOrangeColor,
          //     onChanged: (value) {
          //       log('value : $value');
          //       if(value == true) {
          //         isShowAgain.value = false;
          //       } else if(value == false) {
          //         isShowAgain.value = true;
          //       }
          //
          //     },
          //   ),

          Radio(
            activeColor: activeColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            radioButtonText,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.darkOrangeColor,
            ),
          ),
        ]),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomAlertDialogWithoutRadioButton extends StatelessWidget {
  String text;
  String content;
  String value;
  String groupValue;
  String buttonText;
  Function() onPressed;
  Function(String?)? onChanged;
  Color? activeColor;
  EdgeInsetsGeometry? titlePadding;
  EdgeInsetsGeometry? contentPadding;
  CustomAlertDialogWithoutRadioButton({
    Key? key,
    required this.text,
    required this.content,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.onPressed,
    required this.buttonText,
    required this.activeColor,
    this.titlePadding,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      titlePadding: titlePadding,
      title: Text(
        text,
        style: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.blackColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: contentPadding,
      content: Text(
        content,
        style: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.grey500Color,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        const Divider(
          thickness: 2,
        ),
        ButtonCustom(
          text: buttonText,
          onPressed: onPressed,
          fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayHeavy,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.darkOrangeColor,
        ).commonSymmetricPadding(horizontal: 35),
      ],
    );
  }
}

class CustomLogoutAlertDialog extends StatelessWidget {
  String text;
  String content;
  String yesButtonText;
  String noButtonText;
  Function() onYesPressed;
  Function() onNoPressed;
  // Color? activeColor;
  EdgeInsetsGeometry? titlePadding;
  EdgeInsetsGeometry? contentPadding;
  CustomLogoutAlertDialog({
    Key? key,
    required this.text,
    required this.content,
    required this.onYesPressed,
    required this.onNoPressed,
    required this.yesButtonText,
    required this.noButtonText,
    // required this.activeColor,
    this.titlePadding,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      titlePadding: titlePadding,
      title: Text(
        text,
        style: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.blackColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: contentPadding,
      content: Text(
        content,
        style: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.grey500Color,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        const Divider(thickness: 1),

        Row(
          children: [
            Expanded(
              child: ButtonCustom(
                text: yesButtonText,
                onPressed: onYesPressed,
                fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textFontFamily: FontFamilyText.sFProDisplayHeavy,
                textColor: AppColors.whiteColor2,
                backgroundColor: AppColors.darkOrangeColor,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ButtonCustom(
                text: noButtonText,
                onPressed: onNoPressed,
                fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textFontFamily: FontFamilyText.sFProDisplayHeavy,
                textColor: AppColors.whiteColor2,
                backgroundColor: AppColors.darkOrangeColor,
              ),
            ),
          ],
        ),



      ],
    );
  }
}
