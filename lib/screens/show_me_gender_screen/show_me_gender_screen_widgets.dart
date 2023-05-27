import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/show_me_gender_controller.dart';
import '../../model/authentication_model/gender_select_screen_model/get_gender_model.dart';
import '../../utils/style.dart';

class GenderRadioButtonModule extends StatelessWidget {
  GenderRadioButtonModule({super.key});
  final showMeGenderScreenController = Get.find<ShowMeGenderScreenController>();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Gender",
                style: TextStyleConfig.textStyle(
                  fontFamily: FontFamilyText.sFProDisplayBold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: showMeGenderScreenController.genderList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      showMeGenderScreenController.genderList[index].name,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 15.sp,
                        textColor: AppColors.grey600Color,
                      ),
                    ),
                  ),
                  Radio<Msg>(
                    activeColor: AppColors.darkOrangeColor,
                    value: showMeGenderScreenController.genderList[index],
                    groupValue: showMeGenderScreenController.selectedGenderValue,
                    onChanged: (val) => showMeGenderScreenController.radioButtonChangeFunction(val!),
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
