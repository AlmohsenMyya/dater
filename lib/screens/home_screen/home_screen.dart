import 'dart:developer';
import 'dart:ui';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/screens/filter_screen/filter_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../../common_modules/custom_button.dart';
import '../../constants/app_images.dart';
import '../../utils/preferences/user_preference.dart';
import '../favorite_screen/favorite_screen.dart';
import 'home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      resizeToAvoidBottomInset: false,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Reload button
              GestureDetector(
                  onTap: () async {

                    // if(homeScreenController.isRewindAllow == true) {
                    //   Fluttertoast.showToast(msg: "Please wait...Rewinding");
                      if (homeScreenController.selected.value == true) {
                        homeScreenController.selected.value =
                        await homeScreenController.userPreference
                            .getBoolFromPrefs(
                            key: UserPreference.isragatherInKey);
                        // if (homeScreenController.lastLikeProfileId != "") {
                          await homeScreenController.understandFunction();
                          homeScreenController.cardController.rewind(
                              duration: const Duration(seconds: 1));
                        /*} else {
                          log('No likes');
                        }*/
                        // await homeScreenController.initMethod();
                      }
                      else if (homeScreenController.selected.value == false) {
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
                                          fontFamily:
                                          FontFamilyText.sFProDisplayBold,
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
                                        text: "Undestand",
                                        onPressed: () async {
                                          log("11");
                                          Get.back();
                                          await homeScreenController
                                              .understandFunction();

                                          log("22");
                                        },
                                        fontWeight: FontWeight.bold,
                                        textsize: 14.sp,
                                        textFontFamily:
                                        FontFamilyText.sFProDisplayHeavy,
                                        textColor: AppColors.whiteColor2,
                                        backgroundColor: AppColors
                                            .darkOrangeColor,
                                      ).commonSymmetricPadding(horizontal: 35),
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
                                              color: AppColors.blackColor,
                                            ),
                                            shape: const CircleBorder(),
                                            value:
                                            homeScreenController.selected.value,
                                            onChanged: (value) {
                                              setState(() {
                                                homeScreenController
                                                    .selected.value =
                                                !homeScreenController
                                                    .selected.value;
                                              });
                                            },
                                          ),
                                          Text(
                                            "don't show again",
                                            style: TextStyleConfig.textStyle(
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
              // Heart button
              GestureDetector(
                onTap: () {
                  Get.to(() => FavoriteScreen());
                },
                child: Image.asset(
                  AppImages.hardImage,
                  height: 35,
                  width: 35,
                  // fit: BoxFit.cover
                ),
              ),
              // Filter screen
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
          ).commonSymmetricPadding(horizontal: 20, vertical: 15),
        ),
      ),

      // bottomNavigationBar: Container(),

      body: Obx(
        () => homeScreenController.isLoading.value
            ? const CustomLoader()
            : NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  // log('notification.metrics.pixels : ${notification.metrics.pixels}');
                  // log('notification.metrics.atEdge : ${notification.metrics.atEdge}');
                  if (notification.metrics.atEdge == true &&
                      notification.metrics.pixels > 0.0) {
                    homeScreenController.isVisible.value = false;
                  } else {
                    homeScreenController.isVisible.value = true;
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
                              () => homeScreenController.isLoading.value
                                  ? Container()
                                  : SwipeUserModule(),
                            ),

                            /// Star button - Super love button
                            homeScreenController.suggestionList.isEmpty
                            ? Container()
                            : Positioned(
                              bottom: homeScreenController.physicalDeviceHeight < 2200
                                  ? Get.height * 0.11 : Get.height * 0.13,
                              right: 5.w,
                              child: Obx(
                                () => Visibility(
                                  visible: homeScreenController.isVisible.value,
                                  child: GestureDetector(
                                    onTap: () {
                                      homeScreenController.cardController.next(
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
      // bottomNavigationBar: const BottomNavigationBarModule(),

      // floatingActionButton: homeScreenController.isVisible.value
      //         ? FloatingActionButton(onPressed: () {},
      //   child: const Icon(Icons.star_rounded,
      //             color: AppColors.lightOrangeColor, size: 60),
      // )
      //         : null


      /*floatingActionButton: Visibility(
        visible: homeScreenController.isVisible.value,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            homeScreenController.cardController.next(
              swipeDirection: SwipeDirection.up,
            );
          },
          child: const Icon(
            Icons.star_rounded,
              color: AppColors.lightOrangeColor, size: 60),
        ),
          ),*/

    );
  }
}
