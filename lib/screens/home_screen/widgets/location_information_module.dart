import 'package:dater/constants/messages.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_images.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../model/home_screen_model/suggestions_model.dart';
import '../../../utils/style.dart';

// ignore: must_be_immutable
class LocationInformationModule extends StatelessWidget {
  SuggestionData singleItem;

  LocationInformationModule({super.key, required this.singleItem});

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (singleItem.distance! != "Not available" ||
            singleItem.country != '' ||
            singleItem.homeTown != '') ...[
          Row(
            children: [
              Image.asset(
                AppImages.location2Image,
                height: 3.h,
                width: 3.h,
              ),
              SizedBox(width: 1.w),
              Text(
                "${singleItem.name}${AppMessages.locationText}",
                style: TextStyleConfig.textStyle(
                  fontSize: 16.sp,
                  fontFamily: FontFamilyText.sFProDisplayBold,
                  textColor: AppColors.grey800Color,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          singleItem.distance! == "Not available"
              ? Container()
              : Row(
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      // "${singleItem.homeTown}\n${singleItem.distance} km away",
                      "${singleItem.distance} km away",
                      style: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplaySemibold,
                        textColor: AppColors.grey600Color,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
          singleItem.distance! == "Not available"
              ? Container()
              : SizedBox(height: 2.h),
        ],
        Wrap(
          spacing: 0.0,
          children: List.generate(
            2,
            (int index) {
              return (singleItem.country == '' && index == 0) ||
                      (singleItem.homeTown == '' && index == 1)
                  ? const SizedBox()
                  : Transform(
                      transform: Matrix4.identity()..scale(0.93),
                      child: ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: index == 1
                              ? AssetImage(AppImages.locationHome)
                              : AssetImage(AppImages.locationNow),
                        ).commonOnlyPadding(left: 2),
                        label: Text(
                          index == 0
                              ? "Live in ${singleItem.country!}"
                              : "From ${singleItem.homeTown!}",
                          style: TextStyleConfig.textStyle(
                            fontFamily: FontFamilyText.sFProDisplaySemibold,
                            textColor: AppColors.grey600Color,
                            fontSize: 16,
                          ),
                        ),
                        selected: false,
                        selectedColor: AppColors.darkOrangeColor,
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
