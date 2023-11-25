import 'package:cached_network_image/cached_network_image.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/profile_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class mainProfileImage extends StatelessWidget {
  final controller = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: controller.userImages[0].imageUrl,
            height: Get.height * 0.78,
            width: Get.width,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor2,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  AppImages.swiper1Image,
                  height: Get.height * 0.78,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          //todo switch hereeeeee
          Positioned(
            bottom: 0,
            child: Container(
              height: (controller.userEducation.value == 'Add') &&
                      (controller.userWork.value == 'Add')
                  ? Get.height * 0.076
                  : Get.height * 0.12,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0, 5),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: '${controller.userName.value}, ',
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.whiteColor2,
                      fontSize: 21.sp,
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                    ),
                    children: [
                      TextSpan(
                        text: '${controller.userAge.value}',
                        style: TextStyleConfig.textStyle(
                          textColor: AppColors.whiteColor2,
                          fontSize: 21.sp,
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 1.w)),
                      controller.userVerified.value == "1"
                          ? WidgetSpan(
                              child: Image.asset(
                                AppImages.rightImage,
                                height: 22,
                                width: 22,
                                fit: BoxFit.fill,
                              ).commonOnlyPadding(bottom: 5),
                            )
                          : const WidgetSpan(child: SizedBox()),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                if (controller.userWork.value != 'Add') ...[
                  Row(
                    children: [
                      Image.asset(
                        AppImages.workWhiteImage,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        controller.userWork.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FontFamilyText.sFProDisplaySemibold,
                          color: AppColors.whiteColor2,
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),
                ],
                Row(
                  children: [
                    if (controller.userEducation.value != 'Add') ...[
                      Image.asset(
                        AppImages.educationWhiteImage,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        controller.userEducation.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FontFamilyText.sFProDisplaySemibold,
                          color: AppColors.whiteColor2,
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ).commonSymmetricPadding(horizontal: 10),
          ),
        ],
      ),
    );
  }
}
