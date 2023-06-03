import 'dart:developer';
import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/interests%20_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class InterestsWidgetModule extends StatelessWidget {
  InterestsWidgetModule({Key? key}) : super(key: key);

  final interestsScreenController = Get.find<InterestsScreenController>();

  // var selectedVal = 0;
  // bool  value = true;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: interestsScreenController.categoryList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        return Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.creativeImage),
                SizedBox(width: 1.w),
                Text(
                  interestsScreenController.categoryList[i].categoryName,
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
            Wrap(
              spacing: 3.0,
              children: List.generate(
                interestsScreenController.categoryList[i].options.length,
                (int index) {
                  return Transform(
                    transform: Matrix4.identity()..scale(0.9),
                    child: ChoiceChip(
                      avatar:const CircleAvatar(
                        backgroundImage: AssetImage(AppImages.ballImage),
                      ),
                      label: Text(
                        interestsScreenController
                            .categoryList[i].options[index].name,
                        style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplaySemibold,
                          textColor: interestsScreenController
                                  .categoryList[i].options[index].isSelected
                              ? AppColors.blackDarkColor
                              : AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      selected: interestsScreenController
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
                            ? interestsScreenController
                                .selectedItemCount.value--
                            : null;

                        if (interestsScreenController.selectedItemCount.value >=
                            8) {
                          Fluttertoast.showToast(
                              msg: "You select only 8 Interest");
                        } else {
                          value == true
                              ? interestsScreenController
                                  .selectedItemCount.value++
                              : null;
                          int selectedOptionId = int.parse(
                              interestsScreenController
                                  .categoryList[i].options[index].id);

                          interestsScreenController
                              .selectChoiceOnSelectFunction(
                            value: value,
                            categoryIndex: i,
                            categoryOptionIndex: index,
                            optionId: selectedOptionId,
                          );
                        }
                        interestsScreenController.isLoading(true);
                        interestsScreenController.isLoading(false);
                      },
                    ),
                  ).commonSymmetricPadding(horizontal: 10);
                },
              ).toList(),
            ),
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

class SkipAndNextButtonModule extends StatelessWidget {
  SkipAndNextButtonModule({super.key});

  final interestsScreenController = Get.find<InterestsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => interestsScreenController.isLoading.value
          ? Container()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonCustom(
                    text: AppMessages.skip,
                    textFontFamily: FontFamilyText.sFProDisplayBold,
                    textsize: 15,
                    backgroundColor: AppColors.darkOrangeColor,
                    textColor: AppColors.whiteColor2,
                    onPressed: () async {
                      await interestsScreenController.completeSignUpFunction();
                    },
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Obx(
                    () => Text(
                      "${interestsScreenController.selectedItemCount.value}/8 Selected",
                      style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                          textColor: AppColors.grey500Color,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: ButtonCustom(
                    text: AppMessages.next,
                    textFontFamily: FontFamilyText.sFProDisplayBold,
                    textsize: 15,
                    backgroundColor: AppColors.darkOrangeColor,
                    textColor: AppColors.whiteColor2,
                    onPressed: () async {
                      if (interestsScreenController.selectedItemCount.value ==
                          0) {
                        Fluttertoast.showToast(
                            msg: "Please select at least one interest!");
                      } else {
                        await interestsScreenController
                            .nextButtonClickFunction();
                      }
                    },
                  ),
                ),
              ],
            ).commonSymmetricPadding(horizontal: 25, vertical: 10),
    );
  }
}
