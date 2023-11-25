import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/index_screen/index_bindeing.dart';
import 'package:dater/screens/index_screen/index_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppColors.darkOrangeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  Text(
                    AppMessages.welcome,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: FontFamilyText.fredokaSemiBold,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    AppMessages.welcomeToBambo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyText.fredokaRegular,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 2),
            ),
            points(),
            ButtonCustom(
              text: AppMessages.continueText,
              textsize: 15,
              textFontFamily: FontFamilyText.sFProDisplayBold,
              padding: EdgeInsets.symmetric(vertical: 5),
              backgroundColor: AppColors.whiteColor2,
              textColor: AppColors.blackColor,
              onPressed: () async {
                Get.offAll(() => IndexScreen(), binding: IndexBinding());
              },
            ).paddingSymmetric(horizontal: 20),
          ],
        ),
      ),
    );
  }

  points() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ListItem(AppMessages.kindnessAnd).commonSymmetricPadding(vertical: 14),
        ListItem(AppMessages.weStrive),
        ListItem(AppMessages.asYouExplore).commonSymmetricPadding(vertical: 14),
        ListItem(AppMessages.rememberThat),
      ],
    ).commonOnlyPadding(left: 20);
  }
}

class ListItem extends StatelessWidget {
  ListItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "⚈ ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamilyText.fredokaRegular,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamilyText.fredokaRegular,
            ),
          ),
        ),
      ],
    );
  }
}
