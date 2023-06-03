import 'package:dater/constants/app_images.dart';
import 'package:dater/controller/index_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../utils/style.dart';

class MatchDialog extends StatelessWidget {
  const MatchDialog({
    required this.tName,
    required this.tWork,
    required this.tDistance,
    required this.tImage,
    required this.name,
    required this.work,
    required this.image,
    super.key,
  });

  final String? tName;
  final String? tWork;
  final String? tDistance;
  final String? tImage;
  final String? name;
  final String? work;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        height: 65.h,
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      AppImages.matchDialogSVG,
                    )),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 2.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            ' congratulations ! 🎉 ',
                            style: TextStyleConfig.textStyle(
                              fontFamily: FontFamilyText.sitka,
                              textColor: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'You Have a Match',
                            style: TextStyleConfig.textStyle(
                              fontFamily: FontFamilyText.sFProDisplayBold,
                              textColor: AppColors.whiteColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  tName != null
                                      ? nameText(name: tName ?? '')
                                      : const SizedBox(),
                                  tWork != null
                                      ? workText(work: tWork ?? '')
                                      : const SizedBox(),
                                  tDistance != null &&
                                          tDistance != 'Not available'
                                      ? addressTest(distance: tDistance ?? '')
                                      : const SizedBox(),
                                ],
                              ),
                              SizedBox(
                                width: 1.h,
                              ),
                              personalImage(imgPath: tImage),
                            ],
                          ).commonOnlyPadding(right: 13.w),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              personalImage(imgPath: image),
                              SizedBox(
                                width: 1.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  name != null
                                      ? nameText(name: name!)
                                      : const SizedBox(),
                                  work != null && work != 'Add'
                                      ? workText(work: work!)
                                      : const SizedBox(),
                                  // addressTest(distance: '7'),
                                ],
                              ),
                            ],
                          ).commonOnlyPadding(left: 13.w),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    ButtonCustom(
                      text: 'Send a Message',
                      // size: const Size(22.0, 22.0),
                      onPressed: () {
                        Get.back();
                        Get.find<IndexScreenController>().selectedIndex.value =
                            2;
                      },
                      fontWeight: FontWeight.bold,
                      textsize: 14.sp,
                      textFontFamily: FontFamilyText.sFProDisplayHeavy,
                      textColor: AppColors.whiteColor2,
                      backgroundColor: AppColors.lightOrangeColor,
                    ).commonSymmetricPadding(horizontal: 5.w),
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'Go Back to Discover',
                        style: TextStyleConfig.textStyle(
                          fontFamily: FontFamilyText.sFProDisplaySemibold,
                          textColor: AppColors.darkGreyColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  personalImage({required String? imgPath}) {
    return SizedBox(
      height: 10.h,
      width: 10.h,
      child: imgPath != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(imgPath),
            )
          : const CircleAvatar(),
    );
  }

  nameText({required String name}) {
    return Text(
      name,
      style: TextStyleConfig.textStyle(
        fontFamily: FontFamilyText.sFProDisplaySemibold,
        textColor: AppColors.whiteColor,
        fontSize: 18,
      ),
    );
  }

  workText({required String work}) {
    return Text(
      work,
      style: TextStyleConfig.textStyle(
        fontFamily: FontFamilyText.sFProDisplayMedium,
        textColor: AppColors.whiteColor,
        fontSize: 12,
      ),
    );
  }

  addressTest({required String distance}) {
    return Row(
      children: [
        const Icon(
            size: 15, color: AppColors.whiteColor, Icons.location_on_sharp),
        Text(
          '$distance KM',
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayMedium,
            textColor: AppColors.whiteColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
