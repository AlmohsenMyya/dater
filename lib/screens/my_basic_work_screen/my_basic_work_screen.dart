import 'package:dater/common_function/hide_keyboard.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/my_basic_work_screen_controller.dart';
import '../../utils/style.dart';
import 'my_basic_work_screen_widgets.dart';

class MyBasicWorkScreen extends StatelessWidget {
  MyBasicWorkScreen({Key? key}) : super(key: key);
  final myBasicWorkScreenController = Get.put(MyBasicWorkScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> hideKeyBoard(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor2,
        appBar: commonAppBarModule(text: AppMessages.workHeaderText),
        body: Obx(
          () => myBasicWorkScreenController.isLoading.value
              ? const CustomLoader()
              : SingleChildScrollView(
                child: Form(
                  key: myBasicWorkScreenController.formKey,
                  child: Column(
                      children: [
                        TitleFieldModule()
                            .commonSymmetricPadding(horizontal: 20, vertical: 10),
                        CompanyFieldModule()
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
          await myBasicWorkScreenController.doneButtonClick(),
        ).commonSymmetricPadding(horizontal: 20, vertical: 10),
      ),
    );
  }
}
