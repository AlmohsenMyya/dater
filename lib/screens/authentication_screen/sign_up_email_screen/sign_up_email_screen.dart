import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/controller/auth_screen_controllers/sign_up_email_screen_controller.dart';
import 'package:dater/screens/authentication_screen/sign_up_email_screen/sign_up_email_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpEmailScreen extends StatelessWidget {
  SignUpEmailScreen({Key? key}) : super(key: key);
  final signUpEmailScreenController = Get.put(SignUpEmailScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(),
      backgroundColor: AppColors.whiteColor2,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.gray50Color,
                  image: const DecorationImage(
                    image: AssetImage(AppImages.posterImage),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SignUpEmailScreenWidgets(),
              // const WhatsYourNameEmailModule(),
            ],
          ).commonSymmetricPadding(horizontal: 15, vertical: 20),
        ),
      ),
    );
  }
}
