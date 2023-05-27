import 'package:dater/model/language_select_screen_model/language_model.dart';
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
import '../../controller/language_select_screen_controller.dart';
import '../../utils/style.dart';

class LanguageSelectScreen extends StatelessWidget {
  LanguageSelectScreen({Key? key}) : super(key: key);
  final languageSelectScreenController = Get.put(LanguageSelectScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.languages,
        isLeadingShow: true,
      ),

      body: Obx(
            ()=> languageSelectScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


                Text(
                  AppMessages.whatLanguageKnow,
                  textAlign: TextAlign.center,
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayBold,
                    textColor: AppColors.grey800Color,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 1.h),


                Text(
                  AppMessages.whatLanguageKnowDescription,
                  textAlign: TextAlign.center,
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    textColor: AppColors.grey600Color,
                    fontSize: 12.sp,
                  ),
                ),

            SizedBox(height: 3.h),


            Expanded(
              child: ListView.builder(
                itemCount: languageSelectScreenController.languageList.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  LanguageData singleItem = languageSelectScreenController.languageList[i];
                  return ListTile(
                    title: Text(
                      singleItem.name!,
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        textColor: AppColors.grey600Color,
                        fontSize: 15.sp,
                      ),
                    ),

                    trailing: Checkbox(
                      value: singleItem.isSelected,
                      activeColor: AppColors.lightOrangeColor,
                      onChanged: (value) {
                        languageSelectScreenController.changeSelectedValue(
                          i: i,
                          singleItem: singleItem,
                          value: value!
                        );
                      },
                    ),


                  );
                },
              ),
            ),

            ButtonCustom(
              backgroundColor: AppColors.lightOrangeColor,
              shadowColor: AppColors.grey800Color,
              text: AppMessages.save,
              textColor: AppColors.gray50Color,
              textFontFamily: FontFamilyText.sFProDisplaySemibold,
              textsize: 14.sp,
              onPressed: () async => await languageSelectScreenController.saveButtonCLickFunction(),
              // onPressed: () async => languageSelectScreenController.deneButtonClickFunction(),
            ),
          ],
        ).commonSymmetricPadding(horizontal: 25, vertical: 20),
      ),

    );
  }
}
