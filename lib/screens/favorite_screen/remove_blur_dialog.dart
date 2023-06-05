import 'package:dater/controller/favorite_screen_controller.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../utils/style.dart';

class RemoveBlurDialog extends GetView<HomeScreenController> {
  RemoveBlurDialog({
    required this.removeBlurIndex,
    super.key,
  });

  final int removeBlurIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'See how likes you',
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "remove the blur will cost you 4 coins",
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey500Color,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 8.h,
          width: 100.w,
          child: Column(
            children: [
              ButtonCustom(
                text: 'Confirm',
                size: const Size(22.0, 22.0),
                onPressed: () {
                  Get.find<FavoriteScreenController>()
                      .removeBlur(removeBlurIndex);
                  Get.back();
                },
                fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textFontFamily: FontFamilyText.sFProDisplayHeavy,
                textColor: AppColors.whiteColor2,
                backgroundColor: AppColors.darkOrangeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
