import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/earn_more_coins_screen/earn_more_coins_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/balance_screen_controller.dart';
import '../../utils/style.dart';

class WidgetsBalanceModule extends GetView<BalanceScreenController> {
  WidgetsBalanceModule({Key? key}) : super(key: key);

  // final controller = Get.find<BalanceScreenController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          // color: Colors.cyanAccent,
          child: Image.asset(
            AppImages.balanceHeader,
            width: Get.width,
            height: 9.h,
          ),
        ),

        // Text(
        //   AppMessages.yourBalance,
        //   style: TextStyleConfig.textStyle(
        //     fontFamily: FontFamilyText.sFProDisplayBold,
        //     textColor: AppColors.blackColor,
        //     fontSize: 18.sp,
        //     // fontWeight: FontWeight.bold,
        //   ),
        // ),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          child: Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 3.h, width: Get.width),
                Text(
                  AppMessages.coinsBalance,
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.fredokaSemiBold,
                    textColor: AppColors.darkOrangeColor,
                    fontSize: 20.sp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      fit: BoxFit.contain,
                      width: 31,
                      height: 31,
                      image: const AssetImage(AppImages.balanceIcon),
                    ),
                    SizedBox(
                      height: 10.h,
                      width: 2.w,
                    ),
                    Text(
                      controller.coinValue.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.whitney,
                        textColor: AppColors.blackColor,
                        fontSize: 55.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      stepsWidget(
                          name: AppMessages.totalSteps == ''
                              ? '0'
                              : AppMessages.totalSteps,
                          number: controller.steps.value),
                      stepsWidget(
                          name: AppMessages.todaySteps,
                          number: controller.todaySteps.value.toString()),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                RichText(
                  text: TextSpan(
                      text: 'Your daily rate of coins : ',
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.whitneyReg,
                        textColor: AppColors.blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: '20',
                          style: TextStyleConfig.textStyle(
                            fontFamily: FontFamilyText.whitneyReg,
                            textColor: AppColors.darkOrangeColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 1,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0, // Underline thickness
                  ))),
                  child: GestureDetector(
                    onTap: () {
                      // showComingSoonPopup(context);
                      Get.to(() => EarnMoreCoinsScreen());
                    },
                    child: Text(
                      "Learn more",
                      style: TextStyle(
                        fontFamily: FontFamilyText.whitney,
                        color: AppColors.blackColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Image.asset(
                  AppImages.animalCoins,
                  width: Get.width,
                ),
                SizedBox(
                  height: 4.h,
                ),
                ButtonCustom(
                  text: AppMessages.earnMoreCoins,
                  onPressed: () {
                    controller.getSteps();
                    showComingSoonPopup(context);
                    // Get.to(() => EarnMoreCoinsScreen());
                  },
                  textsize: 14.sp,
                  textFontFamily: FontFamilyText.whitneyReg,
                  textColor: AppColors.whiteColor2,
                  backgroundColor: AppColors.darkOrangeColor,
                  borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  showComingSoonPopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 20,
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: [
            SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Coming soon...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontFamilyText.whitney,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ).commonSymmetricPadding(vertical: 15),
                  Divider(
                    thickness: 1,
                    color: AppColors.grey200Color,
                  ).paddingSymmetric(horizontal: 40),
                  Center(
                    child: ButtonCustom(
                        text: 'Done',
                        textColor: Colors.white,
                        size: Size(88, 40),
                        borderShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        backgroundColor: AppColors.darkOrangeColor,
                        textsize: 15,
                        onPressed: () {
                          Get.back();
                        }),
                  ).commonSymmetricPadding(vertical: 15)
                ],
              ),
            )
          ],
        );
      },
    );
  }

  stepsWidget({required String name, required String? number}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.footPrintsIcon,
          width: 20,
          height: 20,
        ),
        Column(
          children: [
            Text(
              number ?? '0',
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.whitney,
                fontWeight: FontWeight.bold,
                textColor: AppColors.darkOrangeColor,
                fontSize: 12.sp,
              ),
            ),
            Text(
              name,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.whitneyReg,
                textColor: AppColors.grey800Color,
                fontSize: 10.sp,
              ),
            ),
          ],
        )
      ],
    );
  }
}
