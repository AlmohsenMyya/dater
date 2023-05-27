import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_function/hide_keyboard.dart';
import '../../../common_modules/custom_appbar.dart';
import '../../../common_modules/custom_button.dart';
import '../../../common_modules/custom_loader.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../constants/messages.dart';
import '../../../controller/edit_profile_prompts_screen_controller.dart';
import '../../../utils/style.dart';

class EditProfilePromptsScreen extends StatelessWidget {
  EditProfilePromptsScreen({Key? key}) : super(key: key);
  final editProfilePromptsScreenController =
      Get.put(EditProfilePromptsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.profilePromptsHeader,
        isLeadingShow: true,
      ),
      body: Obx(
        () => editProfilePromptsScreenController.isLoading.value
            ? const CustomLoader()
            : SingleChildScrollView(
              child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.lightOrangeColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                              editProfilePromptsScreenController.promptsData.name!,
                            style: TextStyleConfig.textStyle(
                              fontFamily: FontFamilyText.sFProDisplayRegular,
                              textColor: AppColors.grey300Color,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ).commonSymmetricPadding(horizontal: 20, vertical: 25),
                          TextFormField(
                            controller: editProfilePromptsScreenController.typeController,
                            maxLines: 8,
                            style: TextStyleConfig.textStyle(
                            fontFamily: FontFamilyText.sFProDisplayRegular,
                            textColor: AppColors.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Tell us ...",
                              hintStyle: TextStyleConfig.textStyle(
                              fontFamily: FontFamilyText.sFProDisplayRegular,
                              textColor: AppColors.grey300Color,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ).commonSymmetricPadding(horizontal: 20),
                        ],
                      ),
                    ).commonSymmetricPadding(horizontal: 20, vertical: 45),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ButtonCustom(
                            text: AppMessages.cancel,
                            onPressed: () {
                              hideKeyBoard();
                              Get.back();
                            },
                            textsize: 12.sp,
                          ).commonOnlyPadding(right: 50),
                        ),

                        Expanded(
                          child: ButtonCustom(
                            text: AppMessages.done,
                            backgroundColor: AppColors.lightOrangeColor,
                            textColor: AppColors.whiteColor,
                            textsize: 12.sp,
                            onPressed: () async => await editProfilePromptsScreenController.saveButtonClick(),
                          ).commonOnlyPadding(left: 50),
                        ),
                      ],
                    ).commonSymmetricPadding(horizontal: 20),
                  ],
                ),
            ),
      ),
    );
  }
}
