import 'dart:developer';
import 'dart:io';
import 'package:dater/constants/app_images.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/auth_screen_controllers/verify_your_account_screen_controller.dart';
import '../../utils/style.dart';
import '../cms_screen/cms_screen.dart';

class ImageSelectModule extends StatelessWidget {
  ImageSelectModule({Key? key}) : super(key: key);
  final verifyYourAccountScreenController =
      Get.find<VerifyYourAccountScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(
        () => verifyYourAccountScreenController.imagePath.isEmpty
            ? Container(
                height: 27.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // color: AppColors.darkOrangeColor,
                  // boxShadow: const [
                  //   BoxShadow(
                  //     blurRadius: 7.0,
                  //   )
                  // ],
                ),
                child: Image.asset(
                  AppImages.selfieImage,
                  fit: BoxFit.cover,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(
                  File(verifyYourAccountScreenController.imagePath.value),
                  fit: BoxFit.cover,
                  height: 27.h,
                  width: 46.w,
                ),
              ),
      ),
      SizedBox(height: 4.h),
      ButtonCustom(
        text: AppMessages.takePhoto,
        shadowColor: AppColors.grey900Color,
        onPressed: () {
          verifyYourAccountScreenController
              .pickImageFromGallery(ImageSource.camera,);
        },
        // fontWeight: FontWeight.bold,
        textsize: 14.sp,
        textFontFamily: FontFamilyText.sFProDisplayRegular,
        textColor: AppColors.whiteColor2,
        backgroundColor: AppColors.darkOrangeColor,
      ),
    ]).commonSymmetricPadding(horizontal: 100);
  }
}

class VerifyAccountTextModule extends StatelessWidget {
  const VerifyAccountTextModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      RichText(
        //maxLines: 2,
        // textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '1-Try to take a photo with the same position as above',
              style: TextStyleConfig.textStyle(
                textColor: AppColors.grey600Color,
                fontFamily: "SFProDisplayRegular",
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 1.h),
      RichText(
        //maxLines: 2,
        // textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '2-Your face must be clear',
              style: TextStyleConfig.textStyle(
                textColor: AppColors.grey600Color,
                fontFamily: "SFProDisplayRegular",
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 1.h),
      RichText(
        //maxLines: 2,
        // textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '3-You can go to',
              style: TextStyleConfig.textStyle(
                textColor: AppColors.grey600Color,
                fontFamily: "SFProDisplayRegular",
                fontSize: 14.sp,
              ),
              recognizer: TapGestureRecognizer(),
            ),
            TextSpan(
              text: ' privacy policy',
              style: TextStyleConfig.textStyle(
                textColor: AppColors.darkOrangeColor,
                fontFamily: "SFProDisplayRegular",
                fontSize: 18.sp,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(
                    () => CmsScreen(),
                    arguments: [CmsIdentify.privacyPolicy],
                  );
                },
            ),
            TextSpan(
              text: ' to see how we use your data',
              style: TextStyleConfig.textStyle(
                textColor: AppColors.grey600Color,
                fontFamily: "SFProDisplayRegular",
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    ]).commonSymmetricPadding(
      horizontal: 60,
    );
  }
}
