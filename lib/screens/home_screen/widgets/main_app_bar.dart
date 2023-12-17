import 'dart:developer';

import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_button.dart';
import '../../../constants/app_images.dart';
import '../../../utils/preferences/user_preference.dart';
import '../../../utils/style.dart';
import '../../favorite_screen/favorite_screen.dart';
import '../../filter_screen/filter_screen.dart';

class MainAppBar extends GetView<HomeScreenController>
    implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Reload button
          GestureDetector(
            onTap: () async {
              // if(controller.isRewindAllow == true) {
              //   Fluttertoast.showToast(msg: "Please wait...Rewinding");
              if (controller.selected.value == true) {
                controller.selected.value = await controller.userPreference
                    .getBoolFromPrefs(key: UserPreference.isragatherInKey);
                // if (controller.lastLikeProfileId != "") {
                await controller.understandFunction();
                //TODO: remove this after fix the bug from back end
                // controller.cardController
                //     .rewind(duration: const Duration(seconds: 1));
                /*} else {
                        log('No likes');
                      }*/
                // await controller.initMethod();
              } else if (controller.selected.value == false) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      elevation: 50,
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Regather",
                                style: TextStyleConfig.textStyle(
                                  fontSize: 20,
                                  fontFamily: FontFamilyText.sFProDisplayBold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "Every regather will cost you 1 coin",
                                style: TextStyleConfig.textStyle(
                                  fontSize: 14.sp,
                                  fontFamily:
                                      FontFamilyText.sFProDisplayRegular,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              ButtonCustom(
                                text: "Understand",
                                onPressed: () async {
                                  log("11");
                                  Get.back();
                                  await controller.understandFunction();

                                  log("22");
                                },
                                fontWeight: FontWeight.bold,
                                textsize: 14.sp,
                                textFontFamily:
                                    FontFamilyText.sFProDisplayHeavy,
                                textColor: AppColors.whiteColor2,
                                backgroundColor: AppColors.darkOrangeColor,
                              ).commonSymmetricPadding(horizontal: 35),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: AppColors.lightOrangeColor,
                                    hoverColor: AppColors.lightOrangeColor,
                                    activeColor: AppColors.lightOrangeColor,
                                    tristate: false,
                                    side: const BorderSide(
                                      width: 2,
                                      color: AppColors.blackColor,
                                    ),
                                    shape: const CircleBorder(),
                                    value: controller.selected.value,
                                    onChanged: (value) {
                                      setState(() {
                                        controller.selected.value =
                                            !controller.selected.value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "don't show again",
                                    style: TextStyleConfig.textStyle(
                                      fontSize: 14.sp,
                                      fontFamily:
                                          FontFamilyText.sFProDisplayRegular,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              }
              // }
              /*else {
                    log('not allow');
                  }*/
            },
            child: Image.asset(
              AppImages.refreshImage,
              height: 35,
              width: 35,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Bambo',
            style: TextStyle(
              fontFamily: FontFamilyText.fredokaBold,
              color: AppColors.darkOrangeColor,
              fontSize: 35,
            ),
          ),
         Row(
           children: [
             Obx(
                   () => GestureDetector(
                 onTap: () {
                   controller.newLikes.value = false;
                   Get.to(() => FavoriteScreen());
                 },
                 child: Stack(
                   children: [
                     Image.asset(
                       AppImages.hardImage,
                       height: 35,
                       width: 35,
                     ),
                     if (controller.newLikes.value)
                       Positioned(
                         top: 0,
                         right: 0,
                         child: Container(
                           width: 10,
                           height: 10,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: AppColors.darkOrangeColor,
                           ),
                         ),
                       ),
                   ],
                 ),
               ),
             ),
             SizedBox(width: 25,),
             GestureDetector(
               onTap: () {
                 Get.to(
                       () => FilterScreen(),
                 );
               },
               child: Image.asset(
                 AppImages.menuImage,
                 height: 35,
                 width: 35,
               ),
             ),
           ],
         )
        ],
      ).commonSymmetricPadding(horizontal: 20, vertical:0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
