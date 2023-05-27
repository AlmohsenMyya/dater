import 'dart:math';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../controller/home_screen_controller.dart';
import '../../model/home_screen_model/suggestions_model.dart';
import '../../model/profile_screen_models/basic_model.dart';
import '../../utils/style.dart';

/*class CardSwipeModule extends StatelessWidget {
  CardSwipeModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return homeScreenController.suggestionList.isEmpty
        ? SizedBox(
            height: Get.height * 0.70,
            child: const Center(
              child: Text('No Matches Found'),
            ),
          )
        : Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  // Container(
                  //   height: 56.h,
                  //   decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(
                  //         AppImages.lightorange1,
                  //       ),
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ).commonSymmetricPadding(horizontal: 16.w),
                  // Container(
                  //   height: 53.h,
                  //   decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(
                  //         AppImages.lightorange2,
                  //       ),
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ).commonSymmetricPadding(horizontal: 8.w),
                  SizedBox(
                    height: 50.h,
                    child: SwipableStack(
                      allowVerticalSwipe: false,
                      swipeAnchor: SwipeAnchor.bottom,
                      cancelAnimationCurve: Curves.bounceIn,
                      onSwipeCompleted: (index, swipeDirection) async {
                        homeScreenController.currentUserIndex.value = index;
                        int finalIndex = index + 1;
                        print('Swipe Complete finalIndex : $finalIndex');

                        if (swipeDirection == SwipeDirection.right) {
                          await homeScreenController.superLoveProfileFunction(
                            likedId:
                                "${homeScreenController.suggestionList[0].id}",
                            likeType: LikeType.like,
                            swipeCard: true,
                            index: finalIndex,
                          );
                        } else if (swipeDirection == SwipeDirection.left) {
                          // print("Swipe Cancel Button: ${homeScreenController.suggestionList[0].id}");
                          if (finalIndex ==
                              homeScreenController.suggestionList.length) {
                            homeScreenController.suggestionList = [];
                            homeScreenController.loadUI();
                          } else {
                            homeScreenController.setChangedUserData(finalIndex);
                            homeScreenController.loadUI();
                          }
                        } else if (swipeDirection == SwipeDirection.up) {
                          await homeScreenController
                              .understandSuperLoveFunction(finalIndex);
                        }

                        */
/*if (swipeDirection == SwipeDirection.right) {
                          if (homeScreenController.isLikeButtonClick.value == false) {
                            await homeScreenController.superLoveProfileFunction(
                              likedId: "${homeScreenController.suggestionList[index].id}",
                              likeType: LikeType.like,
                              swipeCard: true,
                            );
                            print("Swipe Like Button: ${homeScreenController.suggestionList[0].id}");
                            homeScreenController.isLikeButtonClick(true);
                          } else {
                            homeScreenController.isLikeButtonClick(false);
                          }
                        }*/
/*

                        */
/*else if (swipeDirection == SwipeDirection.up) {
                          if (homeScreenController.isStarButtonClick.value == false) {
                            await homeScreenController.superLoveProfileFunction(
                              likedId: "${homeScreenController.suggestionList[index].id}",
                              likeType: LikeType.super_love,
                              swipeCard: true,
                            );
                            print("Swipe Up Button: ${homeScreenController.suggestionList[0].id}");
                          } else {
                            homeScreenController.isStarButtonClick(false);
                          }
                        }*/
/*

                        */
/*else if (swipeDirection == SwipeDirection.left) {
                          if (homeScreenController.isCancelButtonClick.value == false) {
                            homeScreenController.suggestionList.removeAt(0);
                            print("Swipe Cancel Button: ${homeScreenController.suggestionList[0].id}");
                            homeScreenController.setChangedUserData();
                            homeScreenController.isCancelButtonClick(true);
                            //todo - when user swipe left
                          } else {
                            homeScreenController.isCancelButtonClick(false);
                          }
                        }*/
/*
                      },
                      overlayBuilder: (context, properties) {
                        final opacity = min(properties.swipeProgress, 1.0);
                        // final isRight =
                        //     properties.direction == SwipeDirection.right;

                        SwipeDirectionEnum swipeDirectionEnum =
                            properties.direction == SwipeDirection.right
                                ? SwipeDirectionEnum.right
                                : properties.direction == SwipeDirection.left
                                    ? SwipeDirectionEnum.left
                                    : SwipeDirectionEnum.up;

                        return Container(
                          decoration:
                              const BoxDecoration(color: Colors.white24),
                          child: Opacity(
                            opacity: opacity,
                            child: Center(
                              child:
                                  swipeDirectionEnum == SwipeDirectionEnum.right
                                      ? const Icon(
                                          Icons.favorite,
                                          color: AppColors.lightOrangeColor,
                                          size: 70,
                                        )
                                      : swipeDirectionEnum ==
                                              SwipeDirectionEnum.left
                                          ? const Icon(
                                              Icons.close_rounded,
                                              color: AppColors.whiteColor,
                                              size: 70,
                                            )
                                          : const Icon(
                                              Icons.star_border_rounded,
                                              color: AppColors.whiteColor,
                                              size: 70,
                                            ),
                            ),
                          ),
                        );
                      },
                      controller: homeScreenController.cardController,
                      itemCount: homeScreenController.suggestionList.length,
                      builder: (context, sp) {
                        // MatchPersonData singleItem = homeScreenController.matchesList[sp.index];

                        return homeScreenController.userImageList.isEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppImages.swiper1Image,
                                  width: double.infinity,
                                  fit: BoxFit.fill, //todo
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  homeScreenController
                                      .suggestionList[homeScreenController
                                          .currentUserIndex.value]
                                      .images![0]
                                      .imageUrl,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, obj, st) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        AppImages.swiper1Image,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel Button
                  IconButton(
                    onPressed: () {
                      homeScreenController.cardController.next(
                        swipeDirection: SwipeDirection.left,
                      );
                      */
/*homeScreenController.isCancelButtonClick(true);
                      homeScreenController.suggestionList.removeAt(0);
                      if(homeScreenController.suggestionList.isEmpty) {
                        homeScreenController.suggestionList.clear();
                        homeScreenController.suggestionList = [];
                      } else {
                        homeScreenController.setChangedUserData();
                      }
                      print(
                          "Button Click Cancel: ${homeScreenController.suggestionList[0].id}");
                      //todo - when user swipe left
                      homeScreenController.loadUI();

                      homeScreenController.cardController.next(
                        swipeDirection: SwipeDirection.left,
                        duration: const Duration(milliseconds: 600),
                      );
                      homeScreenController.isCancelButtonClick(false);*/
/*
                    },
                    icon: Image.asset(AppImages.cancelImage),
                  ),

                  // Star Button
                  IconButton(
                    onPressed: () async {
                      homeScreenController.isStarButtonClick(true);

                      if (homeScreenController.selectedSuperLove.value ==
                          true) {
                        homeScreenController.cardController.next(
                          swipeDirection: SwipeDirection.up,
                          duration: const Duration(milliseconds: 1000),
                        );
                        //todo
                      } else if (homeScreenController.selectedSuperLove.value ==
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
                                        "Super love",
                                        style: TextStyleConfig.textStyle(
                                          fontSize: 20,
                                          fontFamily:
                                              FontFamilyText.sFProDisplayBold,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        "Every super love will cost you 4 coins",
                                        style: TextStyleConfig.textStyle(
                                          fontSize: 12.sp,
                                          fontFamily: FontFamilyText
                                              .sFProDisplayRegular,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      ButtonCustom(
                                        text: "Undestand",
                                        onPressed: () async {
                                          Get.back();
                                          homeScreenController.cardController
                                              .next(
                                            swipeDirection: SwipeDirection.up,
                                            duration: const Duration(
                                                milliseconds: 1000),
                                          );
                                        },
                                        fontWeight: FontWeight.bold,
                                        textsize: 14.sp,
                                        textFontFamily:
                                            FontFamilyText.sFProDisplayHeavy,
                                        textColor: AppColors.whiteColor2,
                                        backgroundColor:
                                            AppColors.darkOrangeColor,
                                      ).commonSymmetricPadding(horizontal: 35),
                                      SizedBox(height: 1.h),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor:
                                                AppColors.lightOrangeColor,
                                            hoverColor:
                                                AppColors.lightOrangeColor,
                                            activeColor:
                                                AppColors.lightOrangeColor,
                                            tristate: false,
                                            side: const BorderSide(
                                              width: 2,
                                              color: AppColors.blackColor,
                                            ),
                                            shape: const CircleBorder(),
                                            value: homeScreenController
                                                .selectedSuperLove.value,
                                            onChanged: (value) {
                                              setState(() {
                                                homeScreenController
                                                        .selectedSuperLove
                                                        .value =
                                                    !homeScreenController
                                                        .selectedSuperLove
                                                        .value;
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
                      print(
                          "Button Click Star ${homeScreenController.suggestionList[0].id}");
                    },
                    icon: Image.asset(AppImages.starImage),
                  ),

                  // Like Button
                  IconButton(
                    onPressed: () async {
                      homeScreenController.cardController.next(
                        swipeDirection: SwipeDirection.right,
                      );
                      */
/*homeScreenController.isLikeButtonClick(true);
                      await homeScreenController.superLoveProfileFunction(
                        likedId: "${homeScreenController.singlePersonData.id}",
                        likeType: LikeType.like,
                        swipeCard: false,
                      );
                      homeScreenController.cardController.next(
                        swipeDirection: SwipeDirection.right,
                      );
                      print(
                          "Button Click Like ${homeScreenController.suggestionList[0].id}");*/
/*
                    },
                    icon: Image.asset(AppImages.likeImage),
                  ),
                ],
              ).commonOnlyPadding(left: 15.w, right: 15.w),
              SizedBox(height: 2.h),
              RichText(
                text: TextSpan(
                  text:
                      '${homeScreenController.name.value}, ${homeScreenController.age.value}',
                  style: TextStyleConfig.textStyle(
                    textColor: AppColors.grey800Color,
                    fontSize: 18.sp,
                    fontFamily: FontFamilyText.sFProDisplaySemibold,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    homeScreenController.verifiedUser.value == "0"
                        ? WidgetSpan(
                            child: SizedBox(width: 1.w),
                          )
                        : const WidgetSpan(child: SizedBox()),
                    homeScreenController.verifiedUser.value == "0"
                        ? WidgetSpan(
                            child: Image.asset(AppImages.rightImage)
                                .commonOnlyPadding(bottom: 5),
                          )
                        : const WidgetSpan(child: SizedBox()),
                  ],
                ),
              ),
              */
/*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${homeScreenController.singlePersonData.name}, ${homeScreenController.singlePersonData.age}',
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.grey800Color,
                      fontSize: 18.sp,
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Image.asset(AppImages.rightImage),
                ],
              ),*/
/*
              SizedBox(height: 1.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${homeScreenController.work.value} ",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey600Color,
                        fontSize: 16,
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        // fontWeight: FontWeight.normal,
                      ),
                    ),
                    WidgetSpan(
                      child: Image.asset(AppImages.location2Image, height: 2.h),
                    ),
                    TextSpan(
                      text: " ${homeScreenController.distance.value}",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey600Color,
                        fontSize: 16,
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              homeScreenController.suggestionList[homeScreenController.currentUserIndex.value].images!.length > 2
                  ? SizedBox(
                      height: 56.h,
                      width: Get.width,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          homeScreenController
                              .suggestionList[
                                  homeScreenController.currentUserIndex.value]
                              .images![1]
                              .imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, obj, st) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.swiper1Image,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Text(
                    AppMessages.aboutMe,
                    style: TextStyleConfig.textStyle(
                      fontSize: 16.sp,
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey800Color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  Text(
                    "${homeScreenController.bio}",
                    style: TextStyleConfig.textStyle(
                      fontSize: 13.sp,
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey600Color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              BasicInFormationModule(),
              SizedBox(height: 4.h),
              // InterestsInformationModule(),
              SizedBox(height: 7.h),
              homeScreenController
                          .suggestionList[
                              homeScreenController.currentUserIndex.value]
                          .images!
                          .length >
                      3
                  ? SizedBox(
                      height: 56.h,
                      width: Get.width,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          homeScreenController
                              .suggestionList[
                                  homeScreenController.currentUserIndex.value]
                              .images![2]
                              .imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, obj, st) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.swiper1Image,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
              */
/*Container(
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage(
                      AppImages.swiper1Image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),*/
/*
              SizedBox(height: 5.h),
              // LanguagesInformationModule(),
              SizedBox(height: 7.h),

              UserImageShowModule(
                imageListIndex: 4,
                imageShowIndex: 3,
              ),
              UserImageShowModule(
                imageListIndex: 5,
                imageShowIndex: 4,
              ),
              UserImageShowModule(
                imageListIndex: 6,
                imageShowIndex: 5,
              ),
              UserImageShowModule(
                imageListIndex: 7,
                imageShowIndex: 6,
              ),
              UserImageShowModule(
                imageListIndex: 8,
                imageShowIndex: 7,
              ),
              UserImageShowModule(
                imageListIndex: 9,
                imageShowIndex: 8,
              ),

              // SizedBox(height: 5.h),
              LocationInformationModule(),
            ],
          );
  }
}*/

/*class BasicInFormationModule extends StatelessWidget {
  BasicInFormationModule({super.key});

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    // print("object ${homeScreenController.basicList.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppMessages.basics,
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
          spacing: 3.0,
          children: List.generate(
            homeScreenController.basicList.length,
            (int index) {
              return Transform(
                transform: Matrix4.identity()..scale(0.9),
                child: ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage(
                      homeScreenController.basicList[index].image,
                    ),
                  ).commonOnlyPadding(left: 2),
                  label: Text(
                    homeScreenController.basicList[index].name,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey600Color,
                      fontSize: 16,
                    ),
                  ),
                  selected: homeScreenController.selected.value,
                  selectedColor: AppColors.darkOrangeColor,
                  backgroundColor: AppColors.lightOrangeColor,
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
}*/

// import 'dart:ui';

/// New Widget
class SwipeUserModule extends StatelessWidget {
  SwipeUserModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return homeScreenController.suggestionList.isEmpty
        ? SizedBox(
            height: Get.height * 0.70,
            child: const Center(
              child: Text('No Matches Found'),
            ),
          )
        : Obx(
            () => homeScreenController.isLoading.value
                ? Container()
                : SwipableStack(
                    allowVerticalSwipe: false,
                    swipeAnchor: SwipeAnchor.bottom,
                    cancelAnimationCurve: Curves.bounceIn,
                    stackClipBehaviour: Clip.none,
                    swipeAssistDuration: const Duration(milliseconds: 850),
                    onSwipeCompleted: (index, swipeDirection) async {
                      print('Swipe Complete Index============ : $index');
                      homeScreenController.currentUserIndex.value = index;

                      int finalIndex = index + 1;
                      print('Swipe Complete finalIndex : $finalIndex');

                      /// When swipe Right
                      if (swipeDirection == SwipeDirection.right) {
                        await homeScreenController.superLoveProfileFunction(
                          likedId:
                              "${homeScreenController.suggestionList[index].id}",
                          likeType: LikeType.like,
                          swipeCard: true,
                          index: finalIndex,
                        );
                        homeScreenController.lastLikeProfileId = homeScreenController.suggestionList[index].id!;
                        // homeScreenController.isRewindAllow = true;
                      }

                      /// When swipe Left
                      else if (swipeDirection == SwipeDirection.left) {
                        // print("Swipe Cancel Button: ${homeScreenController.suggestionList[0].id}");
                        if (finalIndex ==
                            homeScreenController.suggestionList.length) {
                          homeScreenController.suggestionList = [];
                          homeScreenController.loadUI();
                        } else {
                          homeScreenController.setChangedUserData(finalIndex);
                          homeScreenController.loadUI();
                        }
                        // homeScreenController.isRewindAllow = false;
                        homeScreenController.lastLikeProfileId = homeScreenController.suggestionList[index].id!;
                      }

                      /// When Swipe Up
                      else if (swipeDirection == SwipeDirection.up) {
                        await homeScreenController
                            .understandSuperLoveFunction(finalIndex);
                        // homeScreenController.isRewindAllow = true;
                        homeScreenController.lastLikeProfileId = homeScreenController.suggestionList[index].id!;
                      }

                    },
                    overlayBuilder: (context, properties) {
                      // properties.swipeProgress;
                      final opacity = min(properties.swipeProgress, 1.0);
                      print('opacity : ${properties.swipeProgress}');

                      SwipeDirectionEnum swipeDirectionEnum =
                          properties.direction == SwipeDirection.right
                              ? SwipeDirectionEnum.right
                              : properties.direction == SwipeDirection.left
                                  ? SwipeDirectionEnum.left
                                  : SwipeDirectionEnum.up;

                      // homeScreenController.hideSuperLoveButtonFunction(swipeDirectionEnum);

                      return Opacity(
                        opacity: opacity,
                        child: Center(
                          child: swipeDirectionEnum == SwipeDirectionEnum.right
                              ? const Icon(
                                  Icons.favorite,
                                  color: AppColors.lightOrangeColor,
                                  size: 70,
                                )
                              : swipeDirectionEnum == SwipeDirectionEnum.left
                                  ? const Icon(
                                      Icons.close_rounded,
                                      color: AppColors.whiteColor,
                                      size: 70,
                                    )
                                  : const Icon(
                                      Icons.star_border_rounded,
                                      color: AppColors.whiteColor,
                                      size: 70,
                                    ),
                        ),
                      );
                    },
                    controller: homeScreenController.cardController,
                    itemCount: homeScreenController.suggestionList.length,
                    builder: (context, sp) {
                      // print('sp.index : ${sp.index}');
                      SuggestionData singleItem =
                          homeScreenController.suggestionList[sp.index];

                      List<String> languageList = homeScreenController
                          .suggestionList[sp.index].languages!;
                      List<Interest> interestList = homeScreenController
                          .suggestionList[sp.index].interest!;
                      List<UserImage> userImagesList =
                          homeScreenController.suggestionList[sp.index].images!;

                      List<BasicModel> basicList = [];
                      basicList = homeScreenController.setBasicListFunction(
                        singleItem: singleItem,
                      );

                      return SingleChildScrollView(
                        // controller: homeScreenController.scrollController,
                        child: Container(
                          color: AppColors.whiteColor2,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// User Main Image module
                              Stack(
                                // alignment: Alignment.bottomCenter,
                                children: [
                                  // User Image Module
                                  singleItem.images!.isNotEmpty
                                      ? Container(
                                          height: homeScreenController
                                                      .physicalDeviceHeight <
                                                  2200
                                              ? Get.height * 0.75
                                              : Get.height * 0.82,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor2,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(singleItem
                                                  .images![0].imageUrl),
                                              fit: BoxFit.cover,
                                              onError: (obj, st) {
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.asset(
                                                    AppImages.swiper1Image,
                                                    height: homeScreenController
                                                                .physicalDeviceHeight <
                                                            2200
                                                        ? Get.height * 0.75
                                                        : Get.height * 0.82,
                                                    width: Get.width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          /*child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        singleItem.images![0].imageUrl,
                                        fit: BoxFit.cover,
                                        // height: 77.h,
                                        // height: Get.height * 0.80,
                                        // width: Get.width,
                                        errorBuilder: (context, obj, st) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.asset(
                                              AppImages.swiper1Image,
                                              width: double.infinity,
                                              fit: BoxFit.contain,
                                            ),
                                          );
                                        },
                                      ),
                                    ),*/
                                        )
                                      : Container(
                                          height: homeScreenController
                                                      .physicalDeviceHeight <
                                                  2200
                                              ? Get.height * 0.75
                                              : Get.height * 0.82,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor2,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  AppImages.swiper1Image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                  /*ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      AppImages.swiper1Image,
                                      height: homeScreenController.physicalDeviceHeight < 2200
                                          ? Get.height * 0.75
                                          : Get.height * 0.82,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),*/

                                  // Shadow position on image
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      height: Get.height * 0.12,
                                      width: Get.width * 0.85,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // User name, age module
                                  Positioned(
                                    bottom: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '${singleItem.name}, ',
                                            style: TextStyleConfig.textStyle(
                                              textColor: AppColors.whiteColor2,
                                              fontSize: 21.sp,
                                              fontFamily: FontFamilyText
                                                  .sFProDisplaySemibold,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${singleItem.age}',
                                                style:
                                                    TextStyleConfig.textStyle(
                                                  textColor:
                                                      AppColors.whiteColor2,
                                                  fontSize: 21.sp,
                                                  fontFamily: FontFamilyText
                                                      .sFProDisplayRegular,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              singleItem.verified == "0"
                                                  ? WidgetSpan(
                                                      child:
                                                          SizedBox(width: 1.w))
                                                  : const WidgetSpan(
                                                      child: SizedBox()),
                                              singleItem.verified == "0"
                                                  ? WidgetSpan(
                                                      child: Image.asset(
                                                        AppImages.rightImage,
                                                        height: 22,
                                                        width: 22,
                                                        fit: BoxFit.fill,
                                                      ).commonOnlyPadding(
                                                          bottom: 5),
                                                    )
                                                  : const WidgetSpan(
                                                      child: SizedBox()),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.workWhiteImage,
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              // "Graphic Design",
                                              singleItem.basic!.work,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: FontFamilyText
                                                    .sFProDisplaySemibold,
                                                color: AppColors.whiteColor2,
                                                fontSize: 9.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.educationWhiteImage,
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              // "University of United State",
                                              singleItem.basic!.education,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: FontFamilyText
                                                    .sFProDisplaySemibold,
                                                color: AppColors.whiteColor2,
                                                fontSize: 9.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).commonSymmetricPadding(horizontal: 10),
                                  ),

                                  // Star Button module
                                  // Positioned(
                                  //   bottom: 35,
                                  //   right: 25,
                                  //   child: IconButton(
                                  //     onPressed: () {
                                  //       homeScreenController.cardController.next(
                                  //         swipeDirection: SwipeDirection.up,
                                  //       );
                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.star_rounded,
                                  //       color: AppColors.lightOrangeColor,
                                  //       size: 60,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),

                              Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // About Module
                                    Container(height: 2.h),
                                    Text(
                                      AppMessages.aboutMe,
                                      style: TextStyleConfig.textStyle(
                                        fontSize: 16.sp,
                                        fontFamily:
                                            FontFamilyText.sFProDisplaySemibold,
                                        textColor: AppColors.grey800Color,
                                      ),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Text(
                                      "${homeScreenController.bio}",
                                      // "Eliza is an experienced graphic designer, with over 10 years of experience "
                                      //     "specializing in logo design. "
                                      //     "Besides hosting several graphic design seminars "
                                      //     "Eliza creates relevant and original logos that "
                                      //     "enhance a company's brand recognition.",
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyleConfig.textStyle(
                                        fontSize: 13.sp,
                                        fontFamily:
                                            FontFamilyText.sFProDisplaySemibold,
                                        textColor: AppColors.grey600Color,
                                      ),
                                    ),
                                    //

                                    // Basic Module
                                    SizedBox(height: 4.h),
                                    BasicInFormationModule(
                                        basicList: basicList),
                                    //

                                    // Interest Module
                                    interestList.isEmpty
                                        ? Container()
                                        : SizedBox(height: 4.h),
                                    interestList.isEmpty
                                        ? Container()
                                        : InterestsInformationModule(
                                            interestList: interestList),
                                    //

                                    // Language Module
                                    languageList.isEmpty
                                        ? Container()
                                        : SizedBox(height: 4.h),
                                    languageList.isEmpty
                                        ? Container()
                                        : LanguagesInformationModule(
                                            languageList: languageList),
                                    //

                                    SizedBox(height: 3.h),

                                    // User 2nd Image Show module
                                    singleItem.images!.length > 1
                                        ? SizedBox(
                                            height: 56.h,
                                            width: Get.width,
                                            // decoration: BoxDecoration(
                                            //   borderRadius: BorderRadius.circular(15),
                                            // ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                singleItem.images![1].imageUrl,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (context, obj, st) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      AppImages.swiper1Image,
                                                      width: double.infinity,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ).commonSymmetricPadding(vertical: 5)
                                        : Container(),
                                    //

                                    // 2nd Prompts show module
                                    // SizedBox(height: 2.h),
                                    singleItem.prompts!.isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleItem.prompts![0].question,
                                                style:
                                                    TextStyleConfig.textStyle(
                                                  fontFamily: FontFamilyText
                                                      .sFProDisplaySemibold,
                                                  textColor:
                                                      AppColors.grey300Color,
                                                  //fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                              SizedBox(height: 1.h),
                                              Container(
                                                width: Get.width,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.grey400Color,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Text(
                                                  singleItem.prompts![0].answer,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyleConfig.textStyle(
                                                    fontFamily: FontFamilyText
                                                        .sFProDisplaySemibold,
                                                    textColor:
                                                        AppColors.grey600Color,
                                                    //fontWeight: FontWeight.w500,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ).commonSymmetricPadding(vertical: 5)
                                        : Container(),
                                    //

                                    /// User Images Module
                                    // User 3rd Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 2,
                                      imageShowIndex: 2,
                                    ),

                                    // User 4th Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 3,
                                      imageShowIndex: 3,
                                    ),

                                    // User 5th Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 4,
                                      imageShowIndex: 4,
                                    ),

                                    // User 6th Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 5,
                                      imageShowIndex: 5,
                                    ),

                                    // User 7th Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 6,
                                      imageShowIndex: 6,
                                    ),

                                    // User 8th Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 7,
                                      imageShowIndex: 7,
                                    ),

                                    // User 9th Image Show module
                                    UserImageShowModule(
                                      userImagesList: userImagesList,
                                      imageListIndex: 8,
                                      imageShowIndex: 8,
                                    ),
                                    //

                                    SizedBox(height: 3.h),

                                    // Location Module
                                    LocationInformationModule(
                                        singleItem: singleItem),
                                    //

                                    SizedBox(height: 4.h),

                                    // Super Love Button
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            homeScreenController.cardController
                                                .next(
                                              swipeDirection: SwipeDirection.up,
                                            );
                                          },
                                          child: const Icon(
                                            Icons.star_rounded,
                                            color: AppColors.lightOrangeColor,
                                            size: 50,
                                          ),
                                        ),
                                        /*IconButton(
                                        onPressed: () {

                                        },
                                        icon: const Icon(
                                          Icons.star_rounded,
                                          color: AppColors.lightOrangeColor,
                                          size: 50,
                                        ),
                                      ),*/
                                      ],
                                    ),

                                    // Close & Like button module
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            homeScreenController.cardController
                                                .next(
                                              swipeDirection:
                                                  SwipeDirection.left,
                                            );
                                          },
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: AppColors.lightOrangeColor,
                                            size: 50,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Hide and Report',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: AppColors.lightOrangeColor,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            homeScreenController.cardController
                                                .next(
                                              swipeDirection:
                                                  SwipeDirection.right,
                                            );
                                          },
                                          child: const Icon(
                                            Icons.favorite_border_outlined,
                                            color: AppColors.lightOrangeColor,
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    ).commonSymmetricPadding(horizontal: 10),

                                    SizedBox(height: 3.h),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      /*return homeScreenController.userImageList.isEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppImages.swiper1Image,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          homeScreenController
                              .suggestionList[
                                  homeScreenController.currentUserIndex.value]
                              .images![0]
                              .imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, obj, st) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.swiper1Image,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      );*/
                    },
                  ),
          );
  }
}

class BasicInFormationModule extends StatelessWidget {
  List<BasicModel> basicList;

  BasicInFormationModule({super.key, required this.basicList});

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    // print("object ${homeScreenController.basicList.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppMessages.basics,
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
          spacing: 3.0,
          children: List.generate(
            basicList.length,
            (int index) {
              return Transform(
                transform: Matrix4.identity()..scale(0.9),
                child: ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage(
                      basicList[index].image,
                    ),
                  ).commonOnlyPadding(left: 2),
                  label: Text(
                    basicList[index].name,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey600Color,
                      fontSize: 16,
                    ),
                  ),
                  selected: false,
                  selectedColor: AppColors.darkOrangeColor,
                  backgroundColor: AppColors.lightOrangeColor,
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
          spacing: 3.0,
          children: List.generate(
            interestList.length,
            (int index) {
              return Transform(
                transform: Matrix4.identity()..scale(0.9),
                child: ChoiceChip(
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.ballImage),
                  ).commonOnlyPadding(left: 2),
                  label: Text(
                    interestList[index].name,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey600Color,
                      fontSize: 16,
                    ),
                  ),
                  selected: false,
                  selectedColor: AppColors.darkOrangeColor,
                  backgroundColor: AppColors.lightOrangeColor,
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

class LanguagesInformationModule extends StatelessWidget {
  List<String> languageList;

  LanguagesInformationModule({super.key, required this.languageList});

  // final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Wrap(
          spacing: 3.0,
          children: List.generate(
            languageList.length,
            (int index) {
              return Transform(
                transform: Matrix4.identity()..scale(0.9),
                child: ChoiceChip(
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.languageImage),
                  ).commonOnlyPadding(left: 2),
                  label: Text(
                    languageList[index],
                    // "English",
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey600Color,
                      fontSize: 16,
                    ),
                  ),
                  selected: false,
                  selectedColor: AppColors.darkOrangeColor,
                  backgroundColor: AppColors.lightOrangeColor,
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

class UserImageShowModule extends StatelessWidget {
  List<UserImage> userImagesList;
  final int imageListIndex;
  final int imageShowIndex;

  UserImageShowModule(
      {Key? key,
      required this.imageListIndex,
      required this.imageShowIndex,
      required this.userImagesList})
      : super(key: key);

  // final screenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    // print('imageListIndex : ${imageListIndex.toString()}');
    // print('imageShowIndex : ${imageShowIndex.toString()}');
    // print('userImagesList : ${userImagesList}');

    return userImagesList.length > imageListIndex
        ? SizedBox(
            height: 56.h,
            width: Get.width,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                userImagesList[imageShowIndex].imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, obj, st) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      AppImages.swiper1Image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ).commonSymmetricPadding(vertical: 5)
        : Container();
  }
}

class LocationInformationModule extends StatelessWidget {
  SuggestionData singleItem;

  LocationInformationModule({super.key, required this.singleItem});

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Wrap(
          spacing: 3.0,
          children: List.generate(
            2,
            (int index) {
              return Transform(
                transform: Matrix4.identity()..scale(0.9),
                child: ChoiceChip(
                  avatar: const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.ballImage),
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
