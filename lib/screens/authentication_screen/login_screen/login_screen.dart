import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/screens/authentication_screen/login_screen/login_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_screen_controllers/login_screen_controller.dart';

class LoginInScreen extends StatelessWidget {
  LoginInScreen({super.key});
  final loginInScreenController = Get.put(LoginInScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.splashBackgroundImage2),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: Obx(
              () => loginInScreenController.isLoading.value
                  ? const CustomLoader()
                  : ColumnWidgets().commonOnlyPadding(
                      top: 5.h, right: 15, left: 15, bottom: 20),
            ),
          ),
        ],
      ),
    );
  }
}
