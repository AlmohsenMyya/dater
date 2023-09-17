import 'dart:math';

import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/interests_images.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/edit_interests_controller.dart';
import 'package:dater/controller/edit_profile_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditInterests extends GetView<EditInterestsController> {
  EditInterests({Key? key}) : super(key: key);

  // final controller = Get.put(EditInterestsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.whatsyourinterests,
        backGroundColor: Colors.transparent,
        iconColor: AppColors.darkOrangeColor,
        textFontFamily: FontFamilyText.sFProDisplayHeavy,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CustomLoader()
            : SafeArea(
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      AppMessages.chooseChatText,
                      style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                          textColor: AppColors.grey500Color,
                          fontSize: 14.sp),
                    ).commonSymmetricPadding(horizontal: 6.w),
                    // const SizedBox(height: 12),
                    Expanded(child: EditInterestsWidgetModule()),
                    // SizedBox(height: 3.h,),
                    // SportsWidgetsModule(),
                  ],
                ).commonOnlyPadding(bottom: 10),
              ),
      ),
      floatingActionButton: ButtonCustom(
        text: 'Done Editing',
        size: Size(20, 20),
        backgroundColor: AppColors.lightOrangeColor,
        onPressed: () async {
          await controller.nextButtonClickFunction();
          await Get.find<EditProfileScreenController>().initMethod();
          Get.back();
        },
      ),
    );
  }
}

class EditInterestsWidgetModule extends GetView<EditInterestsController> {
  EditInterestsWidgetModule({Key? key}) : super(key: key);

  // var selectedVal = 0;
  // bool  value = true;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.categoryList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  width: 20,
                  height: 20,
                  InterestsImages().getLogoPath(
                    controller.categoryList[i].categoryId,
                  ),
                ),
                SizedBox(width: 1.w),
                Text(
                  controller.categoryList[i].categoryName,
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    textColor: AppColors.blackDarkColor,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 50),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Wrap(
                key: ValueKey<bool>(controller.categoryList[i].showMore),
                spacing: 0.0,
                children: List.generate(
                  // interestsScreenController.categoryList[i].options.length,
                  controller.categoryList[i].showMore
                      ? controller.categoryList[i].options.length
                      : min(9, controller.categoryList[i].options.length),
                  (int index) {
                    return Transform(
                      transform: Matrix4.identity()..scale(0.95),
                      child: ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          // backgroundImage: NetworkImage(
                          //   controller.categoryList[i].options[index].image,
                          // ),
                          backgroundImage: AssetImage(
                            InterestsImages().getImagePath(
                              controller.categoryList[i].categoryId,
                              controller.categoryList[i].options[index].id,
                            ),
                          ),
                        ),
                        label: Text(
                          controller.categoryList[i].options[index].name,
                          style: TextStyleConfig.textStyle(
                            fontFamily: FontFamilyText.sFProDisplaySemibold,
                            textColor: controller
                                    .categoryList[i].options[index].isSelected
                                ? AppColors.blackDarkColor
                                : AppColors.blackColor,
                            fontSize: 16,
                          ),
                        ),
                        selected: controller
                            .categoryList[i].options[index].isSelected,
                        selectedColor: AppColors.lightOrange2Color,
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: AppColors.grey400Color,
                            width: 1.5,
                          ),
                        ),
                        onSelected: (bool value) {
                          value == false
                              ? controller.selectedItemCount.value--
                              : null;

                          if (controller.selectedItemCount.value >= 8) {
                            Fluttertoast.showToast(
                                msg: "You select only 8 Interest");
                          } else {
                            value == true
                                ? controller.selectedItemCount.value++
                                : null;
                            int selectedOptionId = int.parse(
                                controller.categoryList[i].options[index].id);

                            controller.selectChoiceOnSelectFunction(
                              value: value,
                              categoryIndex: i,
                              categoryOptionIndex: index,
                              optionId: selectedOptionId,
                            );
                          }
                          controller.isLoading(true);
                          controller.isLoading(false);
                        },
                      ),
                    ).commonSymmetricPadding(horizontal: 1);
                  },
                ).toList(),
              ),
            ),
            if (controller.categoryList[i].options.length > 9) ...[
              ButtonCustom(
                text: controller.categoryList[i].showMore
                    ? "Show Less"
                    : "Show More",
                size: Size(200, 20),
                backgroundColor: AppColors.darkOrangeColor,
                textColor: AppColors.whiteColor2,
                onPressed: () {
                  controller.categoryList[i].showMore =
                      !controller.categoryList[i].showMore;
                  controller.isLoading.value = true;
                  controller.isLoading.value = false;
                },
              ),
            ]
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 5,
          color: AppColors.grey300Color,
        );
      },
    );
  }
}
