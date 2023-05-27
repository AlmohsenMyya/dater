import 'package:dater/controller/earn_more_coins_screen_controller.dart';
import 'package:dater/screens/your_daily_rate_screen/your_daily_rate_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
class EarnMoreCoinsWidgetModule extends StatelessWidget {
   EarnMoreCoinsWidgetModule({Key? key}) : super(key: key);
final earnMoreCoinsScreenController = Get.find<EarnMoreCoinsScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: ButtonCustom(
            text: AppMessages.inviteFriends,
            shadowColor: AppColors.grey900Color,
            onPressed: () {},
            fontWeight: FontWeight.bold,
            textsize: 14.sp,
            textFontFamily: FontFamilyText.sFProDisplayHeavy,
            textColor: AppColors.whiteColor2,
            backgroundColor: AppColors.darkOrangeColor,
          ).commonSymmetricPadding(horizontal: 120),
        ),
        SizedBox(height: 5.h,),
        ButtonCustom(
          text: AppMessages.rateUs,
          shadowColor: AppColors.grey900Color,
          onPressed: () {},
          fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayHeavy,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.darkOrangeColor,
        ).commonSymmetricPadding(horizontal: 120),
        SizedBox(height: 5.h,),
        ButtonCustom(
          text: AppMessages.increaseRate,
          shadowColor: AppColors.grey900Color,
          onPressed: () {
            Get.to(()=> YourDailyRateScreen());
          },
          fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayHeavy,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.darkOrangeColor,
        ).commonSymmetricPadding(horizontal: 120),
      ],
    ).commonSymmetricPadding(vertical: 150);
  }
}
