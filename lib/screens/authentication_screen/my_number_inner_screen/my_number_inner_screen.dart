import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/controller/auth_screen_controllers/my_number_inner_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_appbar.dart';
import '../../../constants/messages.dart';
import 'my_number_inner_screen_widgets.dart';


class MyNumberInnerScreen extends StatelessWidget {
  MyNumberInnerScreen({Key? key}) : super(key: key);
  final myNumberInnerScreenController =
      Get.put(MyNumberInnerScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.myNumberIs),
      body: Obx(
        () => myNumberInnerScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  TextFormFiledModule(),

                  SizedBox(height: 4.h),
                  const TextCustomModule(),
                  SizedBox(height: 7.h),
                  ButtonCustom(
                    size: const Size(double.infinity, 50),
                    backgroundColor: AppColors.lightOrangeColor,
                    shadowColor: Colors.blueGrey,
                    text: AppMessages.continueButton,
                    textColor: AppColors.whiteColor2,
                    fontWeight: FontWeight.bold,
                    textsize: 14.sp,
                    onPressed: () async {
                      await myNumberInnerScreenController.onContinueButtonClickFunction();
                    },
                  ),
                ],
              ).commonSymmetricPadding(horizontal: 15),
      ),
    );
  }
}
