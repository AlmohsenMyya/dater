import 'dart:developer';

import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/model/politics_screen_model/politics_model.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/politics_screen_controller.dart';
import '../../utils/style.dart';

class PoliticsScreen extends StatelessWidget {
  PoliticsScreen({Key? key}) : super(key: key);
  final politicsScreenController = Get.put(PoliticsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.politicsHeader,
        isLeadingShow: true,
      ),

      body: Obx(
        ()=> politicsScreenController.isLoading.value
        ? const CustomLoader()
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: politicsScreenController.politicsList.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  PoliticsData singleItem = politicsScreenController.politicsList[i];
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
                      groupValue: politicsScreenController.selectedPoliticData,
                      activeColor: AppColors.lightOrangeColor,
                      onChanged: (value) {
                        politicsScreenController.changeSelectedValue(value!);

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
              onPressed: () async => politicsScreenController.deneButtonClickFunction(),
            ),
          ],
        ).commonSymmetricPadding(horizontal: 25, vertical: 20),
      ),
    );
  }
}
