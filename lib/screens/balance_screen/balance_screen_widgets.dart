import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/balance_screen_controller.dart';
import '../../utils/style.dart';
import '../earn_more_coins_screen/earn_more_coins_screen.dart';
import '../your_daily_rate_screen/your_daily_rate_screen.dart';


class WidgetsBalanceModule extends StatelessWidget {
  WidgetsBalanceModule({Key? key}) : super(key: key);
  final balanceScreenController = Get.find<BalanceScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppMessages.yourBalance,
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayBold,
            textColor: AppColors.blackColor,
            fontSize: 18.sp,
            // fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 7.h),
        Text(
          AppMessages.coinsBalance,
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplaySemibold,
            textColor: AppColors.grey800Color,
            fontSize: 18.sp,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                fit: BoxFit.contain,
                width: 10.h,
                image: const AssetImage(AppImages.balance2Image)),
            //Image.asset(AppImages.balance2Image),
            Text(
              balanceScreenController.coinValue.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayHeavy,
                textColor: AppColors.grey800Color,
                fontSize: 90,
              ),
            ),
          ],
        ),
        SizedBox(height: 27.h),
        ButtonCustom(
          text: AppMessages.earnMoreCoins,
          onPressed: () {
            Get.to(()=> EarnMoreCoinsScreen());
          },
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayBold,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.darkOrangeColor,
        ),
        SizedBox(height: 5.h),
        Text(
          'Your daily rate of coins : 20',
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            textColor: AppColors.grey600Color,
            fontSize: 16.sp,
            // fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        ButtonCustom(
          size: const Size(40, 0),
          text: AppMessages.learnMore,
          onPressed: () {
            Get.to(YourDailyRateScreen());
          },
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayBold,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.greyColor,
        ),
      ],
    );
  }
}
