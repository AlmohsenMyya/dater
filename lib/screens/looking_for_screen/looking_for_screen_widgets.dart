import 'package:dater/controller/looking_for_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../model/authentication_model/goal_select_screen_model/goal_model.dart';
import '../../utils/style.dart';

class LookingForRadioButtonModule extends StatelessWidget {
  LookingForRadioButtonModule({super.key});
  final lookingForScreenController = Get.find<LookingForScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
        border: Border.all(
          color: AppColors.grey300Color,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Gender",
          //       style: TextStyleConfig.textStyle(
          //         fontFamily: FontFamilyText.sFProDisplayBold,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //   ],
          // ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lookingForScreenController.goalList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      lookingForScreenController.goalList[index].name,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 15.sp,
                        textColor: AppColors.grey600Color,
                      ),
                    ),
                  ),
                  Radio<GoalData>(
                    activeColor: AppColors.darkOrangeColor,
                    value: lookingForScreenController.goalList[index],
                    groupValue: lookingForScreenController.selectedGoalData,
                    onChanged: (val) {
                      // log("val : $val");
                      lookingForScreenController
                          .radioButtonOnChangeFunction(val!);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ).commonSymmetricPadding(horizontal: 25, vertical: 10),
    );
  }
}
