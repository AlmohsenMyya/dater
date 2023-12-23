import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/screens/home_screen/widgets/basic_information_module.dart';
import 'package:dater/screens/home_screen/widgets/interests_information_module.dart';
import 'package:dater/screens/home_screen/widgets/languages_information_module.dart';
import 'package:dater/screens/home_screen/widgets/reports_dialog.dart';
import 'package:dater/screens/home_screen/widgets/user_image_show_module.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../controller/home_screen_controller.dart';
import '../../model/home_screen_model/suggestions_model.dart';
import '../../model/profile_screen_models/basic_model.dart';
import '../../utils/functions.dart';
import '../../utils/style.dart';
import 'widgets/location_information_module.dart';

/// New Widget
class SwipeUserModule extends GetView<HomeScreenController> {
  SwipeUserModule({Key? key}) : super(key: key);

  // final controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    printAll(
        name: 'home screen suggestionList',
        '${controller.suggestionList.length}');
    printAll(
        name: 'Home screen currentUserIndex',
        '${controller.currentUserIndex.value}');
    return Obx(
      () => (controller.cardController.value.currentIndex ==
              controller.suggestionList.length)
          // && !controller.isRewind.value
          ? SizedBox(
              height: Get.height * 0.70,
              child: const Center(
                child:
                    Text('There are no more Users. \n  Please come back soon.'),
              ),
            )
          : SwipableStack(
              detectableSwipeDirections: const {
                SwipeDirection.right,
                SwipeDirection.left,
              },
              onWillMoveNext: (index, direction) {
                final allowedActions = [
                  SwipeDirection.right,
                  SwipeDirection.left,
                  SwipeDirection.up,
                ];
                return allowedActions.contains(direction);
              },
              horizontalSwipeThreshold: 0.3,
              hitTestBehavior: HitTestBehavior.translucent,
              dragStartBehavior: DragStartBehavior.start,
              dragStartCurve: Curves.bounceOut,
              allowVerticalSwipe: false,
              swipeAnchor: SwipeAnchor.top,
              cancelAnimationCurve: Curves.easeOut,
              stackClipBehaviour: Clip.none,
              swipeAssistDuration: const Duration(milliseconds: 400),
              onSwipeCompleted: (index, swipeDirection) async {
                controller.isRewind.value = false;
                // printAll('Swipe Complete Index============ : $index');
                controller.currentUserIndex.value = index;
                int finalIndex = index + 1;
                // homeScreenController
                //     .getUserSuggestionsWithOffset(finalIndex);
                // printAll('Swipe Complete finalIndex : $finalIndex');

                /// When swipe Right
                if (swipeDirection == SwipeDirection.right) {
                  controller.lastLikeProfileId =
                      controller.suggestionList[index].id!;
                  controller.skipped.value = false;

                  await controller.superLoveProfileFunction(
                    likedId: "${controller.suggestionList[index].id}",
                    likeType: LikeType.like,
                    swipeCard: true,
                    index: index,
                  );

                  // homeScreenController.isRewindAllow = true;
                }

                /// When swipe Left
                else if (swipeDirection == SwipeDirection.left) {
                  controller.lastLikeProfileId =
                      controller.suggestionList[index].id!;
                  controller.skipped.value = true;
                  // printAll("Swipe Cancel Button: ${homeScreenController.suggestionList[0].id}");
                  if (finalIndex == controller.suggestionList.length) {
                    // homeScreenController.suggestionList = [];
                    await controller.getUserSuggestionsWithOffset();
                    if (controller.suggestionList.isNotEmpty) {
                      // printAll('not empty');
                      controller.setChangedUserData(index);
                      controller.loadUI();
                    }
                  } else {
                    controller.setChangedUserData(index);
                    controller.loadUI();
                  }
                }

                /// When Swipe Up
                // else if (swipeDirection == SwipeDirection.up) {
                //   controller.lastLikeProfileId =
                //       controller.suggestionList[index].id!;
                //   controller.skipped.value = false;
                //   await controller.understandSuperLoveFunction(index);
                //   // homeScreenController.isRewindAllow = true;
                // }
              },
              overlayBuilder: (context, properties) {
                // properties.swipeProgress;
                final opacity = min(properties.swipeProgress, 1.0);

                // printAll('opacity : ${properties.swipeProgress}');

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
              controller: controller.cardController.value,
              itemCount: controller.suggestionList.length,
              builder: (context, sp) {
                SuggestionData singleItem = controller.suggestionList[sp.index];
                List<String> languageList =
                    controller.suggestionList[sp.index].languages ?? [];
                List<Interest> interestList =
                    controller.suggestionList[sp.index].interest ?? [];
                List<UserImage> userImagesList =
                    controller.suggestionList[sp.index].images ?? [];

                List<BasicModel> basicList = [];
                basicList = controller.setBasicListFunction(
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
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          child: Stack(
                            children: [
// User Image Module
                              singleItem.images!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: singleItem.images![0].imageUrl,
                                      height:
                                          controller.physicalDeviceHeight < 2200
                                              ? Get.height * 0.82
                                              : Get.height * 0.84,
                                      width: Get.width,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor2,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // placeholder: (context, url) => Container(
                                      //   width: 24.0,
                                      //   height: 24.0,
                                      //   child: CircularProgressIndicator(),
                                      // ),
                                      errorWidget: (context, url, error) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            AppImages.swiper1Image,
                                            height: controller
                                                        .physicalDeviceHeight <
                                                    2200
                                                ? Get.height * 0.82
                                                : Get.height * 0.82,
                                            width: Get.width,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      height:
                                          controller.physicalDeviceHeight < 2200
                                              ? Get.height * 0.82
                                              : Get.height * 0.82,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor2,
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              AppImages.swiper1Image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

// Shadow position on image
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: (singleItem.basic!.education == '') &&
                                          (singleItem.basic!.work == '')
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

// User name, age module
                              Positioned(
                                bottom: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style: TextStyleConfig.textStyle(
                                              textColor: AppColors.whiteColor2,
                                              fontSize: 21.sp,
                                              fontFamily: FontFamilyText
                                                  .sFProDisplayRegular,
// fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          WidgetSpan(
                                              child: SizedBox(width: 1.w)),
                                          singleItem.verified == "1"
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
                                    singleItem.basic!.work == ''
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              Image.asset(
                                                AppImages.workWhiteImage,
                                                height: 20,
                                                width: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
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
                                        singleItem.basic!.education == ''
                                            ? const SizedBox()
                                            : Image.asset(
                                                AppImages.educationWhiteImage,
                                                height: 20,
                                                width: 20,
                                              ),
                                        const SizedBox(width: 5),
                                        Text(
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
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
// About Module
                              if (controller.bio.value != '') ...[
                                Container(height: 2.h),
// Container(color: Colors.red,height: 3.h,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Text(
                                    AppMessages.aboutMe,
                                    style: TextStyleConfig.textStyle(
                                      fontSize: 16.sp,
                                      fontFamily:
                                          FontFamilyText.sFProDisplaySemibold,
                                      textColor: AppColors.grey800Color,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "${controller.bio.value}",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleConfig.textStyle(
                                      fontSize: 13.sp,
                                      fontFamily:
                                          FontFamilyText.sFProDisplaySemibold,
                                      textColor: AppColors.grey600Color,
                                    ),
                                  ),
                                ),
                              ],

// Basic Module
                              SizedBox(height: 4.h),
                              BasicInFormationModule(basicList: basicList),

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
                                  ? CachedNetworkImage(
                                      imageUrl: singleItem.images![1].imageUrl,
                                      height: 56.h,
                                      width: Get.width,
                                      imageBuilder: (context, imageProvider) =>
                                          SizedBox(
                                        height: 56.h,
                                        width: Get.width,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            AppImages.swiper1Image,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      },
                                    ).commonSymmetricPadding(vertical: 5)
                                  : Container(),

                              for (int i = 0;
                                  i < (singleItem.prompts?.length ?? 0);
                                  i++) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: Text(
                                        singleItem.prompts![i].question,
                                        style: TextStyleConfig.textStyle(
                                          fontFamily: FontFamilyText
                                              .sFProDisplaySemibold,
                                          textColor: AppColors.grey700Color,
                                          //fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 13),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                            color: AppColors.grey400Color,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          singleItem.prompts![i].answer,
                                          textAlign: TextAlign.center,
                                          style: TextStyleConfig.textStyle(
                                            fontFamily: FontFamilyText
                                                .sFProDisplaySemibold,
                                            textColor: AppColors.blackColor,
                                            //fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).commonSymmetricPadding(vertical: 5)
                              ],
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
//                               UserImageShowModule(
//                                 userImagesList: userImagesList,
//                                 imageListIndex: 5,
//                                 imageShowIndex: 5,
//                               ),
//
// User 7th Image Show module
//                               UserImageShowModule(
//                                 userImagesList: userImagesList,
//                                 imageListIndex: 6,
//                                 imageShowIndex: 6,
//                               ),
//
// // User 8th Image Show module
//                               UserImageShowModule(
//                                 userImagesList: userImagesList,
//                                 imageListIndex: 7,
//                                 imageShowIndex: 7,
//                               ),
//
// // User 9th Image Show module
//                               UserImageShowModule(
//                                 userImagesList: userImagesList,
//                                 imageListIndex: 8,
//                                 imageShowIndex: 8,
//                               ),
//

                              SizedBox(height: 3.h),

// Location Module
                              LocationInformationModule(singleItem: singleItem),
//

                              SizedBox(height: 4.h),

// Super Love Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.cardController.value.next(
                                        swipeDirection: SwipeDirection.up,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.star_rounded,
                                      color: AppColors.lightOrangeColor,
                                      size: 50,
                                    ),
                                  ),
                                ],
                              ),

// Close & Like button module
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      printAll('clear');
                                      controller.cardController.value.next(
                                        swipeDirection: SwipeDirection.left,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: AppColors.lightOrangeColor,
                                      size: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        printAll('hide and report');
                                        Get.dialog(ReportsDialog(
                                          reportsList: controller.reportsList,
                                        ));
                                      },
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
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // printAll('favvvvv');
                                      controller.cardController.value.next(
                                        swipeDirection: SwipeDirection.right,
                                      );
                                    },
                                    child: Icon(
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
              },
            ),
    );
  }
}
