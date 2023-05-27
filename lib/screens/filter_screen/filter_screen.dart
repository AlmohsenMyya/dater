import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/filter_screen_controller.dart';
import 'package:dater/screens/filter_screen/filter_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final filterScreenController = Get.put(FilterScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarModule(text: AppMessages.filter),
      backgroundColor: AppColors.whiteColor2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppMessages.filterScreenText,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      fontSize: 15.sp,
                      textColor: AppColors.grey500Color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              AllFilterFeaturesModule(),
            ],
          ).commonSymmetricPadding(horizontal: 25, vertical: 20),
        ),
      ),
    );
  }
}
