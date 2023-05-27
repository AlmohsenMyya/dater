import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/location_Permission_Screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LocationPermissionScreen extends StatelessWidget {
  LocationPermissionScreen({super.key});
  final locationPermissionController = Get.put(LocationPermissionController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content:
        //         Text('Pop Screen Disabled. You cannot go to previous screen.'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor2,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppImages.locationImage,
                height: 200,
              ),
            ),
          ],
        ),
        bottomNavigationBar: ButtonCustom(
          backgroundColor: AppColors.darkOrangeColor,
          text: AppMessages.locationPermission,
          fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textColor: AppColors.gray50Color,
          onPressed: () async {
            await locationPermissionController.getPermission();
          },
          shadowColor: AppColors.grey900Color,
        ).commonSymmetricPadding(horizontal: 25, vertical: 30),
      ),
    );
  }
}
