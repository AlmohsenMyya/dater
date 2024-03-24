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

class CustomAlertDialogManyTitles extends StatelessWidget {
  final List<String> titles;
  final List<String> contents;
  final String value;
  final String groupValue;
  final String buttonText;
  final Function() onPressed;
  final Function(String?)? onChanged;
  final Color? activeColor;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? contentPadding;

  CustomAlertDialogManyTitles({
    Key? key,
    required this.titles,
    required this.contents,
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
    List<Widget> children = [];

    for (int i = 0; i < titles.length; i++) {
      children.addAll([
        Text(
          titles[i],
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            textColor: AppColors.blackColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      // Adjust spacing between title and content
        Text(
          contents[i],
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            textColor: AppColors.grey500Color,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
      ]);

      // Add divider between sections except for the last one
      // if (i != titles.length - 1) {
      //   children.add(const Divider(thickness: 1));
      // }
    }

    children.addAll([
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
    ]);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
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

/// copy this for dialog Support Trees by Walking
/*
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  CustomAlertDialogWithoutRadioButton(
                              text: 'Support Trees by Walking',
                              content: ''' At Bambo, we believe in making a difference. As you go about your daily walks, earn virtual coins inside the app as a reward for your physical activity.

These coins can later be spent on premium services, allowing you to enhance your dating experience while contributing to the environment. It's a win-win situation!''',
                              buttonText: 'Got it',
                              value: "value",
                              groupValue: "groupValue",
                              onPressed: () {
                                Get.back();
                              },
                              onChanged: (value) {
                                log("value 111 : $value");
                                // favoriteScreenController.isLoading(true);
                                // if(favoriteScreenController.isShowAgain.value == "no") {
                                //   favoriteScreenController.isShowAgain.value = "yes";
                                // } else {
                                //   favoriteScreenController.isShowAgain.value = "no";
                                // }
                                // // favoriteScreenController.isShowAgain.value = value!;
                                // favoriteScreenController.isLoading(false);
                                // log("value 222 : $value");
                              },
                              activeColor: AppColors.darkOrangeColor,
                              // radioButtonText: "don't show again",
                            );

                          });
* */

/// copy this for dialog Be respectful & Kind
/*  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialogManyTitles(
                              titles: [
                                'Be respectful & kind',
                                'Respect boundaries',
                                'Unmatch or block & report'
                              ],
                              contents: [
                                'Acknowledge and honor the limits others set',
                                'Avoid any disrespectful behavior or language ',
                                'If interactions become uncomfortable or inappropriate, you can end communication by unmatching or blocking the individual. Additionally, report any misconduct to the platform for review and action'
                              ],
                              value: 'someValue',
                              groupValue: 'someGroupValue',
                              onChanged: (value) {
                                log("value 111 : $value");
                                // favoriteScreenController.isLoading(true);
                                // if(favoriteScreenController.isShowAgain.value == "no") {
                                //   favoriteScreenController.isShowAgain.value = "yes";
                                // } else {
                                //   favoriteScreenController.isShowAgain.value = "no";
                                // }
                                // // favoriteScreenController.isShowAgain.value = value!;
                                // favoriteScreenController.isLoading(false);
                                // log("value 222 : $value");
                              },
                              activeColor: AppColors.darkOrangeColor,
                              onPressed: () {Get.back();},
                              buttonText: 'Got it ',
                              // radioButtonText: "don't show again",
                            );
                          });*/

/// copy this for dialog Find love, find friends
/*
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return  CustomAlertDialogWithoutRadioButton(
                              text: 'Find love, find friends',
                              content: ''' Your next great connection awaits!\n\n  When you swipe right, you'll spend virtual coins. No need to fret! Earn virtual coins within the app as a reward for your daily walks. ''',
                              buttonText: 'Start swiping',
                              value: "value",
                              groupValue: "groupValue",
                              onPressed: () {
                                Get.back();
                              },
                              onChanged: (value) {
                                log("value 111 : $value");
                                // favoriteScreenController.isLoading(true);
                                // if(favoriteScreenController.isShowAgain.value == "no") {
                                //   favoriteScreenController.isShowAgain.value = "yes";
                                // } else {
                                //   favoriteScreenController.isShowAgain.value = "no";
                                // }
                                // // favoriteScreenController.isShowAgain.value = value!;
                                // favoriteScreenController.isLoading(false);
                                // log("value 222 : $value");
                              },
                              activeColor: AppColors.darkOrangeColor,
                              // radioButtonText: "don't show again",
                            );

                          });
*/
