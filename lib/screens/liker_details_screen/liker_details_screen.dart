import 'package:dater/constants/colors.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../common_modules/custom_loader.dart';
import '../../constants/app_images.dart';
import '../../controller/liker_details_screen_controller.dart';
import '../favorite_screen/favorite_screen.dart';
import '../filter_screen/filter_screen.dart';
import 'liker_details_screen_widgets.dart';

class LikerDetailsScreen extends StatelessWidget {
  LikerDetailsScreen({Key? key}) : super(key: key);
  final likerDetailsScreenController = Get.put(LikerDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => likerDetailsScreenController.isLoading.value
            ? const CustomLoader()
            : NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            // log('notification.metrics.pixels : ${notification.metrics.pixels}');
            // log('notification.metrics.atEdge : ${notification.metrics.atEdge}');
            if (notification.metrics.atEdge == true &&
                notification.metrics.pixels > 0.0) {
              likerDetailsScreenController.isVisible.value = false;
            } else {
              likerDetailsScreenController.isVisible.value = true;
            }
            return false;
            // if (notification.metrics.pixels <= 90) {
            //   notifier.value = notification.metrics.pixels;
            // }

            /*homeScreenController.scrollController.addListener(() {
                    if (homeScreenController.scrollController.position.pixels > 1.0 ||
                        homeScreenController.scrollController.position.pixels <
                            homeScreenController.scrollController.position.maxScrollExtent) {
                      homeScreenController.isVisible.value = true;
                      homeScreenController.loadUI();
                    } else {
                      homeScreenController.isVisible.value = false;
                      homeScreenController.loadUI();
                    }
                  });*/

            // homeScreenController.loadUI();

            /*if (notification.metrics.atEdge) {
              if (notification.metrics.pixels < 0) {
                log('scrollController.position.pixels :${notification.metrics.pixels}');
                if (homeScreenController.isVisible.value) {
                  homeScreenController.isLoading(true);
                  homeScreenController.isVisible.value = false;
                  homeScreenController.isLoading(false);
                }
                homeScreenController.loadUI();
              }
            } else {
              if (!homeScreenController.isVisible.value) {
                homeScreenController.isVisible.value = true;
              }
              homeScreenController.loadUI();
            }*/

            // final ScrollDirection direction = notification.direction;
            // // setState(() {
            // if (direction == ScrollDirection.reverse) {
            //   homeScreenController.isVisible.value = false;
            // } else if (direction == ScrollDirection.forward) {
            //   homeScreenController.isVisible.value = true;
            // }
            // // });
            // return true;
          },
          child: SafeArea(
            child: Column(
              children: [
                // SizedBox(height: 2.h),

                /// Header module
                /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Reload button
                          GestureDetector(
                              onTap: () {
                                if (homeScreenController.selected.value == true) {
                                  homeScreenController.understandFunction();
                                } else if (homeScreenController.selected.value ==
                                    false) {
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
                                                  style:
                                                      TextStyleConfig.textStyle(
                                                    fontSize: 20,
                                                    fontFamily: FontFamilyText
                                                        .sFProDisplayBold,
                                                  ),
                                                ),
                                                SizedBox(height: 2.h),
                                                Text(
                                                  "Every regather will cost you 1 coin",
                                                  style:
                                                      TextStyleConfig.textStyle(
                                                    fontSize: 14.sp,
                                                    fontFamily: FontFamilyText
                                                        .sFProDisplayRegular,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                ButtonCustom(
                                                  text: "Undestand",
                                                  onPressed: () async {
                                                    log("11");

                                                    await homeScreenController
                                                        .understandFunction();
                                                    Get.back();
                                                    log("22");
                                                  },
                                                  fontWeight: FontWeight.bold,
                                                  textsize: 14.sp,
                                                  textFontFamily: FontFamilyText
                                                      .sFProDisplayHeavy,
                                                  textColor:
                                                      AppColors.whiteColor2,
                                                  backgroundColor:
                                                      AppColors.darkOrangeColor,
                                                ).commonSymmetricPadding(
                                                    horizontal: 35),
                                                SizedBox(height: 1.h),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      checkColor: AppColors
                                                          .lightOrangeColor,
                                                      hoverColor: AppColors
                                                          .lightOrangeColor,
                                                      activeColor: AppColors
                                                          .lightOrangeColor,
                                                      tristate: false,
                                                      side: const BorderSide(
                                                        width: 2,
                                                        color:
                                                            AppColors.blackColor,
                                                      ),
                                                      shape: const CircleBorder(),
                                                      value: homeScreenController
                                                          .selected.value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          homeScreenController
                                                                  .selected
                                                                  .value =
                                                              !homeScreenController
                                                                  .selected.value;
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      "don't show again",
                                                      style: TextStyleConfig
                                                          .textStyle(
                                                        fontSize: 14.sp,
                                                        fontFamily: FontFamilyText
                                                            .sFProDisplayRegular,
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
                              },
                              child: Image.asset(AppImages.refreshImage)),
                          // Heart button
                          GestureDetector(
                            onTap: () {
                              Get.to(() => FavoriteScreen());
                            },
                            child: Image.asset(AppImages.hardImage),
                          ),
                          // Filter screen
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => FilterScreen(),
                              );
                            },
                            child: Image.asset(AppImages.menuImage),
                          ),
                        ],
                      ),*/
                // SizedBox(height: 2.h),

                // Swipe Card
                // CardSwipeModule(),

                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(
                            () => likerDetailsScreenController.isLoading.value
                            ? Container()
                            : LikerSwipeUserModule(),
                      ),

                      /// Star button - Super love button
                      /*likerDetailsScreenController.suggestionList.isEmpty
                          ? Container()
                          :*/ Positioned(
                        bottom: likerDetailsScreenController.physicalDeviceHeight < 2200
                            ? Get.height * 0.21 : Get.height * 0.23,
                        right: 5.w,
                        child: Obx(
                              () => Visibility(
                            visible: likerDetailsScreenController.isVisible.value,
                            child: GestureDetector(
                              onTap: () {
                                likerDetailsScreenController.cardController.next(
                                  swipeDirection: SwipeDirection.up,
                                );
                              },
                              child: const Icon(Icons.star_rounded,
                                  color: AppColors.lightOrangeColor,
                                  size: 60),
                            ),
                            /*child: IconButton(
                                      onPressed: () {
                                        homeScreenController.cardController
                                            .next(
                                          swipeDirection: SwipeDirection.up,
                                        );
                                      },
                                      icon: const Icon(Icons.star_rounded,
                                          color: AppColors.lightOrangeColor,
                                          size: 60)
                                  ),*/
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).commonSymmetricPadding(horizontal: 30, vertical: 0),
          ),
        ),
      ),

      /*body: Obx(
        () => likerDetailsScreenController.isLoading.value
        ? const CustomLoader()
        : SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 4.h),
                */
      /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppImages.refreshImage),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => FavoriteScreen());
                      },
                      child: Image.asset(AppImages.hardImage),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                              () => FilterScreen(),
                        );
                      },
                      child: Image.asset(AppImages.menuImage),
                    ),


                    // Swipe Card
                    LikerCardSwipeModule(),
                  ],
                ),
                SizedBox(height: 2.h),*/
      /*
                LikerCardSwipeModule(),
              ],
            ).commonSymmetricPadding(horizontal: 30, vertical: 20),
          ),
        ),
      ),*/


    );
  }
}
