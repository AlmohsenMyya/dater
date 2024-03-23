import 'dart:math';

import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/interests_images.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/interests%20_screen_controller.dart';
import 'package:dater/screens/index_screen/index_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/style.dart';
import '../../index_screen/index_bindeing.dart';

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
                Image.asset(
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                  InterestsImages().getLogoPath(
                    interestsScreenController.categoryList[i].categoryId,
                  ),
                ),
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
            AnimatedSwitcher(
              duration: Duration(milliseconds: 50),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Wrap(
                key: ValueKey<bool>(
                    interestsScreenController.categoryList[i].showMore),
                spacing: 0.0,
                children: List.generate(
                  // interestsScreenController.categoryList[i].options.length,
                  interestsScreenController.categoryList[i].showMore
                      ? interestsScreenController.categoryList[i].options.length
                      : min(
                          9,
                          interestsScreenController
                              .categoryList[i].options.length),
                  (int index) {
                    return Transform(
                      transform: Matrix4.identity()..scale(0.95),
                      child: ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          // backgroundImage: NetworkImage(
                          //   interestsScreenController
                          //       .categoryList[i].options[index].image,
                          // ),
                          backgroundImage: AssetImage(
                            InterestsImages().getImagePath(
                              interestsScreenController
                                  .categoryList[i].categoryId,
                              interestsScreenController
                                  .categoryList[i].options[index].id,
                            ),
                          ),
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

                          if (interestsScreenController
                                  .selectedItemCount.value >=
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
                    ).commonSymmetricPadding(horizontal: 1);
                  },
                ).toList(),
              ),
            ),
            if (interestsScreenController.categoryList[i].options.length >
                9) ...[
              ButtonCustom(
                text: interestsScreenController.categoryList[i].showMore
                    ? "Show Less"
                    : "Show More",
                size: Size(200, 20),
                backgroundColor: AppColors.darkOrangeColor,
                textColor: AppColors.whiteColor2,
                onPressed: () {
                  interestsScreenController.categoryList[i].showMore =
                      !interestsScreenController.categoryList[i].showMore;
                  interestsScreenController.isLoading.value = true;
                  interestsScreenController.isLoading.value = false;
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
                      Get.offAll(() => IndexScreen(), binding: IndexBinding());
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
                        Get.offAll(() => IndexScreen(), binding: IndexBinding());
                      }
                    },
                  ),
                ),
              ],
            ).commonSymmetricPadding(horizontal: 25, vertical: 10),
    );
  }
}
