import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/splash_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  final splashScreenController = Get.put(SplashScreenController());

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(AppImages.appIcon), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.splashBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height / 3.4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 125,
                      height: 125,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImages.appIcon),
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      AppMessages.bambo,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.whiteColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: FontFamilyText.bullpen3D,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 1.h),
                // Text(
                //   textAlign: TextAlign.center,
                //   AppMessages.bambo,
                //   style: TextStyleConfig.textStyle(
                //     textColor: AppColors.whiteColor,
                //     fontFamily: "SFProDisplayRegular",
                //     fontSize: 23.sp,
                //   ),
                // ),
                // SizedBox(height: 4.h),
                // Text(
                //   textAlign: TextAlign.center,
                //   AppMessages.findWhat,
                //   style: TextStyleConfig.textStyle(
                //     fontFamily: FontFamilyText.bullpen3D,
                //     textColor: AppColors.whiteColor,
                //     fontWeight: FontWeight.w500,
                //     fontSize: 30,
                //   ),
                // ),
                // Text(
                //   textAlign: TextAlign.center,
                //   AppMessages.completesYou,
                //   style: TextStyleConfig.textStyle(
                //     fontFamily: FontFamilyText.bullpen3D,
                //     textColor: AppColors.whiteColor,
                //     fontWeight: FontWeight.w500,
                //     fontSize: 30,
                //   ),
                // ),
              ],
            ).commonOnlyPadding(top: 30),
          ),
        ],
      ),
    );
  }
}
