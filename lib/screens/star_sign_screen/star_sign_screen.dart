import 'package:dater/model/star_sign_screen_model/star_sign_model.dart';
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
import '../../controller/star_sign_screen_controller.dart';
import '../../utils/style.dart';

class StarSignScreen extends StatelessWidget {
  StarSignScreen({Key? key}) : super(key: key);
  final starSignScreenController = Get.put(StarSignScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(
        text: AppMessages.starSignHeader,
        isLeadingShow: true,
      ),

      body: Obx(
            ()=> starSignScreenController.isLoading.value
            ? const CustomLoader()
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: starSignScreenController.starSignList.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  StarSignData singleItem = starSignScreenController.starSignList[i];
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
                      groupValue: starSignScreenController.selectedStarSign,
                      activeColor: AppColors.lightOrangeColor,
                      onChanged: (value) {
                        starSignScreenController.changeSelectedValue(value!);

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
              onPressed: () async => starSignScreenController.deneButtonClickFunction(),
            ),
          ],
        ).commonSymmetricPadding(horizontal: 25, vertical: 20),
      ),

    );
  }
}
