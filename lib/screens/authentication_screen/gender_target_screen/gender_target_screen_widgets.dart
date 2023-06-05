import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/gender_target_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../model/authentication_model/gender_select_screen_model/get_gender_model.dart';
import '../../../utils/style.dart';

class GenderTargetRadioButtonModule extends StatelessWidget {
  GenderTargetRadioButtonModule({super.key});

  final genderTargetScreenController = Get.find<GenderTargetScreenController>();

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
                AppMessages.gender,
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
            itemCount: genderTargetScreenController.mainGenderList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      genderTargetScreenController.mainGenderList[index].name,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 15.sp,
                        textColor: AppColors.grey600Color,
                      ),
                    ),
                  ),
                  Radio<Msg>(
                    activeColor: AppColors.darkOrangeColor,
                    value: genderTargetScreenController.mainGenderList[index],
                    groupValue:
                        genderTargetScreenController.selectedGenderValue,
                    onChanged: (val) => genderTargetScreenController
                        .radioButtonOnChangeFunction(val!),
                  ),
                ],
              );
            },
          ),
          // DropdownButton<Msg>(
          //   hint: const Text("Add more about your gender"),
          //   value: !genderTargetScreenController.nonBinaryGenderList
          //           .contains(genderTargetScreenController.selectedGenderValue)
          //       ? null
          //       : genderTargetScreenController.selectedGenderValue,
          //   onChanged: (Msg? val) =>
          //       genderTargetScreenController.radioButtonOnChangeFunction(val!),
          //   items: genderTargetScreenController.nonBinaryGenderList
          //       .map((Msg gender) {
          //     return DropdownMenuItem<Msg>(
          //       value: gender,
          //       child: Row(
          //         children: <Widget>[
          //           Text(
          //             gender.name,
          //             style: const TextStyle(color: Colors.black),
          //           ),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // ),
        ],
      ).commonSymmetricPadding(horizontal: 25, vertical: 10),
    );
  }
}

class GenderTargetNotesModule extends StatelessWidget {
  const GenderTargetNotesModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Container(),
        ),
        Expanded(
          flex: 85,
          child: Column(
            children: [
              _singleItemModule(
                number: AppMessages.targetGenderNumber1,
                text: AppMessages.youCanAlwaysChangeYourTargetGenderLater,
              ),
              _singleItemModule(
                number: AppMessages.targetGenderNumber2,
                text: AppMessages.youwillonlyseepeopleyouaretargeting,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _singleItemModule({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            fontSize: 18,
            color: AppColors.grey500Color,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 18,
              color: AppColors.grey500Color,
            ),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 6);
  }
}
