import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/filter_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ToggleSwitchCustomModule extends StatelessWidget {
  String labelText;
  Function(bool) onToggle;
  RxBool onTogglevalue;

  ToggleSwitchCustomModule({
    Key? key,
    required this.labelText,
    required this.onToggle,
    required this.onTogglevalue,
  }) : super(key: key);
  final filterScreenController = Get.find<FilterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey600Color,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.grey400Color,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppMessages.addThisFilter,
                style: TextStyleConfig.textStyle(
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  textColor: AppColors.blackDarkColor,
                  fontSize: 18,
                ),
              ),
              Obx(
                () => Transform.scale(
                  scale: 0.7,
                  child: FlutterSwitch(
                    // toggleSize: 40.0,
                    activeColor: AppColors.darkOrangeColor,
                    activeToggleColor: AppColors.blackColor,
                    inactiveToggleColor: AppColors.blackColor,
                    inactiveSwitchBorder: Border.all(
                      width: 3,
                      color: AppColors.blackColor,
                    ),
                    activeSwitchBorder: Border.all(
                      width: 3,
                      color: AppColors.blackColor,
                    ),
                    onToggle: onToggle,

                    value: onTogglevalue.value,
                  ),
                ),
              )
            ],
          ).commonOnlyPadding(left: 10.w, right: 1.w),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}

class RangeSliderModule extends StatelessWidget {
  RangeValues rangeValues;
  RxString text;
  double min;
  double max;
  Function(RangeValues) sliderOnChanged;

  RangeSliderModule({
    Key? key,
    required this.rangeValues,
    required this.text,
    required this.sliderOnChanged,
    required this.min,
    required this.max,
  }) : super(key: key);
  final filterScreenController = Get.find<FilterScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () => Text(
                text.value,
                style: TextStyleConfig.textStyle(
                  fontFamily: FontFamilyText.sFProDisplaySemibold,
                  textColor: AppColors.grey600Color,
                ),
              ),
            )
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 1,
          ),
          child: RangeSlider(
              activeColor: AppColors.lightOrangeColor,
              inactiveColor: AppColors.darkGreyColor,
              min: min,
              max: max,
              values: rangeValues,
              onChanged: sliderOnChanged),
        ),
      ],
    );
  }
}
