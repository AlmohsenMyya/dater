import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/authentication_screen/my_number_inner_screen/my_number_inner_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/enums.dart';
import '../../../controller/auth_screen_controllers/login_screen_controller.dart';

class ColumnWidgets extends StatelessWidget {
  ColumnWidgets({super.key});

  final screenController = Get.find<LoginInScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Image.asset(AppImages.appIconWithName),
                    ),
                  ],
                ),
                // SizedBox(height: 0.5.h),
                // Text(
                //   AppMessages.bambo,
                //   style: TextStyle(
                //       fontSize: 25.sp,
                //       shadows: [
                //         Shadow(
                //           blurRadius: 6,
                //           offset: Offset(0,3),
                //         )
                //       ],
                //       fontFamily: FontFamilyText.fredokaBold,
                //       color: AppColors.whiteColor,
                //       fontWeight: FontWeight.w300),
                // ),
                // SizedBox(
                //   height: 4.h,
                // ),
                // Text(
                //     textAlign: TextAlign.center,
                //     AppMessages.walk,
                //     style: TextStyleConfig.textStyle(
                //       fontFamily: FontFamilyText.bullpen3D,
                //       textColor: AppColors.whiteColor,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 32,
                //     )),
                // Text(
                //     textAlign: TextAlign.center,
                //     AppMessages.findWhat,
                //     style: TextStyleConfig.textStyle(
                //       fontFamily: FontFamilyText.bullpen3D,
                //       textColor: AppColors.whiteColor,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 32,
                //     )),
                // Text(
                //     textAlign: TextAlign.center,
                //     AppMessages.completesYou,
                //     style: TextStyleConfig.textStyle(
                //       fontFamily: FontFamilyText.bullpen3D,
                //       textColor: AppColors.whiteColor,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 32,
                //     )),
              ],
            )),
        Expanded(
          flex: 20,
          child: Column(
            children: [
              /*screenController.isUserFirstTime.value
              ? Column(
                children: [
                  /// Register Button
                  ButtonCustomLoginAndSignUp(
                    image: AppImages.mobileImage,
                    onPressed: () {
                      Get.to(
                            () => MyNumberInnerScreen(),
                        arguments: [AuthAs.register],
                      );
                    },
                    text: AppMessages.signUpWithphoneNumber,
                    textsize: 12.sp,
                    textColor: AppColors.grey700Color,
                  ),
                  SizedBox(height: 2.h),

                  /// Login Button
                  ButtonCustomLoginAndSignUp(
                    image: AppImages.mobileImage,
                    onPressed: () {
                      Get.to(
                            () => MyNumberInnerScreen(),
                        arguments: [AuthAs.login],
                      );
                    },
                    text: AppMessages.signInWithphoneNumber,
                    textsize: 12.sp,
                    textColor: AppColors.grey700Color,
                  ),
                ],
              )
              : Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    /// Login Button
                    ButtonCustomLoginAndSignUp(
                      image: AppImages.mobileImage,
                      onPressed: () {
                        Get.to(
                              () => MyNumberInnerScreen(),
                          arguments: [AuthAs.login],
                        );
                      },
                      text: AppMessages.signInWithphoneNumber,
                      textsize: 12.sp,
                      textColor: AppColors.grey700Color,
                    ),
                    Spacer(),
                  ],
                ),
              ),*/

              /// Register Button
              // screenController.isUserFirstTime.value
              // ? ButtonCustomLoginAndSignUp(
              //   image: AppImages.mobileImage,
              //   onPressed: () {
              //     Get.to(
              //       () => MyNumberInnerScreen(),
              //       arguments: [AuthAs.register],
              //     );
              //   },
              //   text: AppMessages.signUpWithphoneNumber,
              //   textsize: 12.sp,
              //   textColor: AppColors.grey700Color,
              // )
              // : Container(),
              // /*screenController.isUserFirstTime.value
              // ?*/ SizedBox(height: 2.h)/* : Container()*/,
              // screenController.isUserFirstTime.value
              // ? Container() : Spacer(),
              /// Login Button
              ButtonCustomLoginAndSignUp(
                // image: AppImages.mobileImage,
                onPressed: () {
                  Get.to(
                    () => MyNumberInnerScreen(isEmail:  true),
                    arguments: [AuthAs.login],
                  );
                },
                text: AppMessages.signInWithEmail,
                // AppMessages.signInWithphoneNumber,
                textsize: 12.sp,
                textColor: AppColors.grey700Color,
              ),

              SizedBox(height: 6.h),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppMessages.authScreen1,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.blackColor,
                        fontFamily: FontFamilyText.whitneyReg,
                        fontSize: 11.5.sp,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            screenController.urlLauncher(AppMessages.termsUrl),
                      text: AppMessages.terms,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.blackColor,
                        fontFamily: FontFamilyText.whitney,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppMessages.authText2,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.blackColor,
                        fontFamily: FontFamilyText.whitneyReg,
                        fontSize: 11.5.sp,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => screenController
                            .urlLauncher(AppMessages.privacyUrl),
                      text: AppMessages.privacyPolicy,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.blackColor,
                        fontFamily: FontFamilyText.whitney,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppMessages.and,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.blackColor,
                        fontFamily: FontFamilyText.whitneyReg,
                        fontSize: 11.5.sp,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => screenController
                            .urlLauncher(AppMessages.communityUrl),
                      text: AppMessages.communityGuidelines,
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.blackColor,
                        fontFamily: FontFamilyText.whitney,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Text(
              //   textAlign: TextAlign.center,
              //   AppMessages.referralNumber,
              //   style: TextStyleConfig.textStyle(
              //       textColor: AppColors.grey800Color,
              //       fontSize: 13.sp,
              //       fontFamily: "SFProDisplayBold"),
              // ).commonSymmetricPadding(horizontal: 15),
              // const Spacer(),
              // Text(
              //   AppMessages.termsOfUseAndPrivacyPolice,
              //   style: TextStyleConfig.textStyle(
              //     textColor: AppColors.whiteColor,
              //   ),
              // )
            ],
          ).commonSymmetricPadding(horizontal: 10),
        ),
        // SizedBox(height: .h),
      ],
    );
  }
}
