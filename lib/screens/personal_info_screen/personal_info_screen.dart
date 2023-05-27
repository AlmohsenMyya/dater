import 'package:dater/screens/personal_info_screen/personal_info_screen_widgets.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/messages.dart';
import '../../controller/personal_info_screen_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({Key? key}) : super(key: key);
  final personalInfoScreenController = Get.put(PersonalInfoScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.phoneNumber),
      bottomNavigationBar: ButtonCustom(
        size: const Size(double.infinity, 50),
        backgroundColor: AppColors.lightOrangeColor,
        shadowColor: Colors.blueGrey,
        text: AppMessages.nextButton,
        textColor: AppColors.whiteColor2,
        fontWeight: FontWeight.bold,
        textsize: 14.sp,
        onPressed: () async {
          await personalInfoScreenController.nextButtonClickFunction();
          // await personalInfoScreenController.onContinueButtonClickFunction();
        },
      ).commonSymmetricPadding(horizontal: 20, vertical: 15),
      body: Obx(
        () => personalInfoScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFiled1Module(),
                    SizedBox(height: 4.h),
                    const TextCustomModule(),
                    SizedBox(height: 7.h),
                  ],
                ).commonSymmetricPadding(horizontal: 25),
              ),
      ),
    );
  }
}
