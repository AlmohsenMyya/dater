import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_images.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../constants/messages.dart';
import '../../../model/home_screen_model/suggestions_model.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class InterestsInformationModule extends StatelessWidget {
  List<Interest> interestList;

  InterestsInformationModule({super.key, required this.interestList});

  // final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppMessages.interests,
              style: TextStyleConfig.textStyle(
                fontSize: 16.sp,
                fontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.grey800Color,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 0.0,
          children: List.generate(
            interestList.length,
            (int index) {
              return Transform(
                transform: Matrix4.identity()..scale(0.93),
                child: ChoiceChip(
                  avatar: interestList[index].image != AppImages.ballImage
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(interestList[index].image),
                        ).commonOnlyPadding(left: 0)
                      : CircleAvatar(
                          backgroundImage:
                              AssetImage(interestList[index].image),
                        ),
                  label: Text(
                    interestList[index].name,
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
        )
      ],
    );
  }
}
