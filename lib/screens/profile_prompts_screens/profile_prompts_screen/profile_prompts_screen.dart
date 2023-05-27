import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_appbar.dart';
import '../../../common_modules/custom_loader.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../constants/messages.dart';
import '../../../controller/profile_prompts_screen_controller.dart';
import '../../../model/profile_prompts_screen_models/profile_prompts_model.dart';
import '../../../utils/style.dart';
import '../edit_profile_prompts_screen/edit_profile_prompts_screen.dart';



class ProfilePromptsScreen extends StatelessWidget {
  ProfilePromptsScreen({Key? key}) : super(key: key);
  final profilePromptsScreenController =
      Get.put(ProfilePromptsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.profilePromptsHeader,
        isLeadingShow: true,
      ),
      body: Obx(
        () => profilePromptsScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Text(
                    AppMessages.pickProfilePrompts,
                    textAlign: TextAlign.start,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayBold,
                      textColor: AppColors.grey800Color,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),


                  Text(
                    AppMessages.pickProfilePromptsDescription,
                    textAlign: TextAlign.start,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      textColor: AppColors.grey600Color,
                      fontSize: 12.sp,
                    ),
                  ),

                  SizedBox(height: 3.h),

                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          profilePromptsScreenController.promptsList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        PromptsData singleItem = profilePromptsScreenController.promptsList[i];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => EditProfilePromptsScreen(),
                              arguments: [singleItem],
                            );
                          },
                          child: Container(
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.lightOrangeColor,
                            ),
                            child: Center(
                              child: Text(
                                  singleItem.name!,
                                textAlign: TextAlign.center,
                                style: TextStyleConfig.textStyle(
                                  fontFamily: FontFamilyText.sFProDisplayRegular,
                                  textColor: AppColors.whiteColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ).commonSymmetricPadding(vertical: 10, horizontal: 35),
                          ).commonSymmetricPadding(vertical: 10),
                        );
                      },
                    ),
                  ),
                ],
              ).commonSymmetricPadding(horizontal: 25, vertical: 20),
      ),
    );
  }
}
