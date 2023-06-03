// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dater/common_modules/switch_and_slider.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/filter_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';

class AllFilterFeaturesModule extends StatelessWidget {
  AllFilterFeaturesModule({super.key});

  final filterScreenController = Get.find<FilterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ToggleSwitchCustomModule(
          labelText: AppMessages.whatIsTheirAge,
          onToggle: (bool value) {
            filterScreenController.isLoading(true);
            filterScreenController.onSelectedAge.value = value;
            filterScreenController.isLoading(false);
          },
          onTogglevalue: filterScreenController.onSelectedAge,
        ),
        Obx(
          () => filterScreenController.onSelectedAge.value
              ? RangeSliderModule(
                  min: 18,
                  max: 100,
                  rangeValues: RangeValues(
                    filterScreenController.startValAge.value,
                    filterScreenController.endValAge.value,
                  ),
                  text:
                      "${filterScreenController.startValAge.value.toStringAsFixed(0)}-${filterScreenController.endValAge.value.toStringAsFixed(0)}"
                          .obs,
                  sliderOnChanged: (RangeValues value) {
                    filterScreenController.isLoading(true);
                    filterScreenController.startValAge.value = value.start;
                    filterScreenController.endValAge.value = value.end;

                    filterScreenController.isLoading(false);
                  },
                )
              : Container(),
        ),
        SizedBox(height: 3.h),
        ToggleSwitchCustomModule(
          labelText: AppMessages.whatIsTheirDistance,
          onToggle: (bool value) {
            filterScreenController.isLoading(true);
            filterScreenController.onSelectedDistance.value = value;
            filterScreenController.isLoading(false);
          },
          onTogglevalue: filterScreenController.onSelectedDistance,
        ),
        Obx(
          () => filterScreenController.onSelectedDistance.value
              ? RangeSliderModule(
                  min: 1,
                  max: 300,
                  rangeValues: RangeValues(
                    filterScreenController.startValDistance.value,
                    filterScreenController.endValDistance.value,
                  ),
                  text:
                      "${filterScreenController.startValDistance.value.toStringAsFixed(0)}-${filterScreenController.endValDistance.value.toStringAsFixed(0)}"
                          .obs,
                  sliderOnChanged: (RangeValues value) {
                    filterScreenController.isLoading(true);
                    filterScreenController.startValDistance.value = value.start;
                    filterScreenController.endValDistance.value = value.end;

                    filterScreenController.isLoading(false);
                  },
                )
              : Container(),
        ),
        SizedBox(
          height: 3.h,
        ),
        ButtonCustom(
          text: 'Save',
          onPressed: () {},
          fontWeight: FontWeight.bold,
          textsize: 14.sp,
          textFontFamily: FontFamilyText.sFProDisplayHeavy,
          textColor: AppColors.whiteColor2,
          backgroundColor: AppColors.darkOrangeColor,
        ),
        // SizedBox(height: 3.h),
        // ToggleSwitchCustomModule(
        //   labelText: AppMessages.doTheyExercise,
        //   onToggle: (bool value) {
        //     filterScreenController.isLoading(true);
        //     filterScreenController.onSelectedExercise.value = value;
        //     filterScreenController.isLoading(false);
        //   },
        //   onTogglevalue: filterScreenController.onSelectedExercise,
        // ),
        // Obx(
        //   () => filterScreenController.onSelectedExercise.value
        //       ? RangeSliderModule(
        //           rangeValues: RangeValues(
        //             filterScreenController.startValExercise.value,
        //             filterScreenController.endValExercise.value,
        //           ),
        //           text:
        //               "${filterScreenController.startValExercise.value.toStringAsFixed(0)}-${filterScreenController.endValExercise.value.toStringAsFixed(0)}"
        //                   .obs,
        //           sliderOnChanged: (RangeValues value) {
        //             filterScreenController.isLoading(true);
        //             filterScreenController.startValExercise.value = value.start;
        //             filterScreenController.endValExercise.value = value.end;
        //
        //             filterScreenController.isLoading(false);
        //           },
        //         )
        //       : Container(),
        // ),
        // SizedBox(height: 3.h),
        // ToggleSwitchCustomModule(
        //   labelText: AppMessages.whatYourGatherDate,
        //   onToggle: (bool value) {
        //     filterScreenController.isLoading(true);
        //     filterScreenController.onSelectedRatherDate.value = value;
        //     filterScreenController.isLoading(false);
        //   },
        //   onTogglevalue: filterScreenController.onSelectedRatherDate,
        // ),
        // Obx(
        //   () => filterScreenController.onSelectedRatherDate.value
        //       ? RangeSliderModule(
        //           rangeValues: RangeValues(
        //             filterScreenController.startValRatherDate.value,
        //             filterScreenController.endValRatherDate.value,
        //           ),
        //           text:
        //               "${filterScreenController.startValRatherDate.value.toStringAsFixed(0)}-${filterScreenController.endValRatherDate.value.toStringAsFixed(0)}"
        //                   .obs,
        //           sliderOnChanged: (RangeValues value) {
        //             filterScreenController.isLoading(true);
        //             filterScreenController.startValRatherDate.value =
        //                 value.start;
        //             filterScreenController.endValRatherDate.value = value.end;
        //
        //             filterScreenController.isLoading(false);
        //           },
        //         )
        //       : Container(),
        // ),
      ],
    );
  }
}
