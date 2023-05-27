import 'package:dater/model/religion_screen_models/religion_model.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/religion_screen_controller.dart';
import '../../utils/style.dart';

class ReligionScreen extends StatelessWidget {
  ReligionScreen({Key? key}) : super(key: key);
  final religionScreenController = Get.put(ReligionScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.religionHeader,
        isLeadingShow: true,
      ),

      body: Obx(
            ()=> religionScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: religionScreenController.religionList.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  ReligionData singleItem = religionScreenController.religionList[i];
                  return ListTile(
                    title: Text(
                      singleItem.name!,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        textColor: AppColors.grey600Color,
                        fontSize: 15.sp,
                      ),
                    ),

                    trailing: Radio(
                      value: singleItem,
                      groupValue: religionScreenController.selectedReligionData,
                      activeColor: AppColors.lightOrangeColor,
                      onChanged: (value) {
                        religionScreenController.changeSelectedValue(value!);

                      },
                    ),
                  );
                },
              ),
            ),

            ButtonCustom(
              backgroundColor: AppColors.lightOrangeColor,
              shadowColor: AppColors.grey800Color,
              text: AppMessages.done,
              textColor: AppColors.gray50Color,
              textFontFamily: FontFamilyText.sFProDisplaySemibold,
              textsize: 14.sp,
              onPressed: () async => religionScreenController.deneButtonClickFunction(),
            ),
          ],
        ).commonSymmetricPadding(horizontal: 25, vertical: 20),
      ),


    );
  }
}
