import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/my_basic_gender_screen_controller.dart';
import '../../model/authentication_model/gender_select_screen_model/get_gender_model.dart';
import '../../utils/style.dart';


class BasicGenderRadioButtonModule extends StatelessWidget {
  BasicGenderRadioButtonModule({super.key});
  final screenController = Get.find<MyBasicGenderScreenController>();
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
            itemCount: screenController.sexualityList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      screenController.sexualityList[index].name,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 15.sp,
                        textColor: AppColors.grey600Color,
                      ),
                    ),
                  ),
                  Radio<Msg>(
                    activeColor: AppColors.darkOrangeColor,
                    value: screenController.sexualityList[index],
                    groupValue: screenController.selectedSexualityValue,
                    onChanged: (val) => screenController.radioButtonChangeFunction(val!),
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

class SexualityShowModule extends StatelessWidget {
  SexualityShowModule({Key? key}) : super(key: key);
  final screenController = Get.find<MyBasicGenderScreenController>();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Show on your profile",
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayBold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Obx(
                    () => Transform.scale(
                  scale: 0.60,
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
                    onToggle: (value) {
                      screenController.isLoading(true);
                      screenController.isShowOnProfile.value = value;
                      screenController.isLoading(false);
                    },
                    value: screenController.isShowOnProfile.value,
                  ),
                ),
              ),
            ],
          ),

          Text(
            "Shown as :",
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 15.sp,
              textColor: AppColors.grey600Color,
            ),
          ).commonSymmetricPadding(vertical: 10),

          ChoiceChip(
           /* avatar: const CircleAvatar(
              backgroundImage: AssetImage(AppImages.languageImage),
            ),*/
            label: Text(
              screenController.selectedSexualityValue.name,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.blackColor,
                fontSize: 16,
              ),
            ),
            selected: true,
            selectedColor: AppColors.lightOrangeColor,
            backgroundColor: Colors.white,
            shape: const StadiumBorder(
              side: BorderSide(
                color: AppColors.grey400Color,
                width: 1.5,
              ),
            ),
            onSelected: (bool value) {},
          )

        ],
      ).commonSymmetricPadding(horizontal: 25, vertical: 10),
    );
  }
}
