import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/profile_screen/profile_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_loader.dart';
import '../../controller/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileScreenController = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor2,
      appBar:
          commonAppBarModule(text: AppMessages.myProfile, isLeadingShow: false),
      body: Obx(
        () => profileScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileModule(),
                    ProfileTextModule(),
                    // SizedBox(height: 3.h),
                    AboutMeAllModule(),
                  ],
                ).commonSymmetricPadding(horizontal: 1),
              ),
      ),
    );
  }
}
