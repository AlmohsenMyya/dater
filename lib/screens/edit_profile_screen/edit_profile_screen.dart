import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/messages.dart';
import '../../controller/edit_profile_screen_controller.dart';
import 'edit_profile_screen_widgets.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final editProfileScreenController = Get.put(EditProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.editProfile,
        isLeadingShow: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return editProfileScreenController.initMethod();
        },
        child: Obx(
          () => editProfileScreenController.isLoading.value
              ? const CustomLoader()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileStrengthModule(),
                      ReorderableGridViewModule(),
                      SizedBox(height: 2.h),
                      EditProfileScreenWidgets()
                    ],
                  ).commonSymmetricPadding(horizontal: 25, vertical: 20),
                ),
        ),
      ),
    );
  }
}
