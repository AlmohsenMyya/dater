import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_function/hide_keyboard.dart';
import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/my_basic_education_screen_controller.dart';
import 'my_basic_education_screen_widgets.dart';

class MyBasicEducationScreen extends StatelessWidget {
  MyBasicEducationScreen({Key? key}) : super(key: key);
  final myBasicEducationScreenController = Get.put(MyBasicEducationScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> hideKeyBoard(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor2,
        appBar: commonAppBarModule(text: AppMessages.educationHeaderText),
        body: Obx(
              () => myBasicEducationScreenController.isLoading.value
              ? const CustomLoader()
              : SingleChildScrollView(
            child: Form(
              key: myBasicEducationScreenController.formKey,
              child: Column(
                children: [
                  InstitutionFieldModule()
                      .commonSymmetricPadding(horizontal: 20, vertical: 10),
                  GraduationYearFieldModule()
                      .commonSymmetricPadding(horizontal: 20, vertical: 10),
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: ButtonCustom(
          text: "Done",
          textFontFamily: FontFamilyText.sFProDisplayBold,
          textsize: 15,
          backgroundColor: AppColors.darkOrangeColor,
          textColor: AppColors.whiteColor2,
          onPressed: () async =>
          await myBasicEducationScreenController.doneButtonClick(),
        ).commonSymmetricPadding(horizontal: 20, vertical: 10),
      ),
    );
  }
}
