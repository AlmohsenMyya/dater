import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_images.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../constants/messages.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class LanguagesInformationModule extends StatelessWidget {
  List<String> languageList;

  LanguagesInformationModule({super.key, required this.languageList});

  // final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppMessages.languagesIKnow,
                style: TextStyleConfig.textStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamilyText.sFProDisplayBold,
                  textColor: AppColors.grey800Color,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Wrap(
              spacing: 0.0,
              children: List.generate(
                languageList.length,
                (int index) {
                  return Transform(
                    transform: Matrix4.identity()..scale(0.94),
                    child: ChoiceChip(
                      avatar: const CircleAvatar(
                        radius: 9.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(AppImages.languageImage),
                      ),
                      label: Text(
                        languageList[index],
                        // "English",
                        style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplaySemibold,
                          textColor: AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                      selected: true,
                      selectedColor: AppColors.lightOrange2Color,
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: AppColors.grey400Color,
                          width: 1.5,
                        ),
                      ),
                      onSelected: (bool value) {},
                    ),
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}
