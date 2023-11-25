import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:dater/screens/profile_screen/profile_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_loader.dart';
import '../../controller/profile_screen_controller.dart';
import '../settings_screen/settings_screen.dart';
import 'custom_slider.dart';
import 'main_profile_image.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileScreenController = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor2,
      // appBar:
      //     commonAppBarModule(text: AppMessages.myProfile, isLeadingShow: false),
      body: RefreshIndicator(
        onRefresh: () {
          return profileScreenController.initMethod();
        },
        child: Obx(
          () => profileScreenController.isLoading.value
              ? const CustomLoader()
              : SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 5.h,
                        // ),
                        header(),
                        SizedBox(
                          height: 1.h,
                        ),
                        // ProfileModule(),
                        // ProfileTextModule(),
                        mainProfileImage(),
                        AboutMeAllModule(),
                      ],
                    ).commonSymmetricPadding(horizontal: 8),
                  ),
                ),
        ),
      ),
    );
  }

  header() {
    return SizedBox(
      height: 9.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            onPressed: () => Get.to(() => SettingsScreen()),
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.darkGreyColor,
              size: 23,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Profile strength',
                style: TextStyle(
                  fontFamily: FontFamilyText.whitneyReg,
                  color: AppColors.blackColor,
                  fontSize: 12.sp,
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                  thumbShape: CustomSliderThumbCircle(thumbRadius: 14),
                ),
                child: Slider(
                  min: 0.0,
                  max: 100.0,
                  activeColor: AppColors.lightOrangeColor,
                  inactiveColor: AppColors.darkGreyColor,
                  value: profileScreenController.userPercentage.value,
                  onChanged: (double value) {},
                ),
              ),
            ],
          ),
          IconButton(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.zero,
              onPressed: () => Get.to(() => EditProfileScreen(),
                          arguments: [profileScreenController.userDetails])!
                      .then((value) async {
                    // await screenController.setDataInUserVariablesFunction();
                    profileScreenController.clearOldUserDataFunction();
                    await profileScreenController.getUserDetailsFunction();
                  }),
              icon: Icon(
                Icons.edit_outlined,
                color: AppColors.darkGreyColor,
                size: 23,
              ))
        ],
      ),
    );
  }
}
