import 'dart:math';

import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../constants/app_images.dart';
import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/liker_details_screen_controller.dart';
import '../../model/liker_details_screen_model/liker_user_details_model.dart';
import '../../model/profile_screen_models/basic_model.dart';
import '../../utils/style.dart';

/// New Widget
class LikerSwipeUserModule extends StatelessWidget {
  LikerSwipeUserModule({Key? key}) : super(key: key);
  final homeScreenController = Get.find<LikerDetailsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
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
                // homeScreenController.currentUserIndex.value = index;

                int finalIndex = index + 1;
                print('Swipe Complete finalIndex : $finalIndex');

                /// When swipe Right
                if (swipeDirection == SwipeDirection.right) {
                  await homeScreenController.superLoveProfileFunction(
                    likedId: "${homeScreenController.userDetails.id}",
                    likeType: LikeType.like,
                    // swipeCard: true,
                    // index: finalIndex,
                  );
                  // homeScreenController.lastLikeProfileId =
                  // homeScreenController.suggestionList[index].id!;
                  // homeScreenController.isRewindAllow = true;
                }

                /// When swipe Left
                else if (swipeDirection == SwipeDirection.left) {
                  Get.back();
                  /*if (finalIndex ==
                homeScreenController.suggestionList.length) {
              homeScreenController.suggestionList = [];
              homeScreenController.loadUI();
            } else {
              homeScreenController.setChangedUserData(finalIndex);
              homeScreenController.loadUI();
            }
            homeScreenController.isRewindAllow = false;*/
                }

                /// When Swipe Up
                else if (swipeDirection == SwipeDirection.up) {
                  await homeScreenController
                      .understandSuperLoveFunction(finalIndex);
                  // homeScreenController.isRewindAllow = true;
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
              itemCount: 1,
              builder: (context, sp) {
                // print('sp.index : ${sp.index}');
                UserDetails singleItem = homeScreenController.userDetails;

                List<String> languageList =
                    homeScreenController.userDetails.languages!;
                List<Interest> interestList =
                    homeScreenController.userDetails.interest!;
                List<UserImage> userImagesList =
                    homeScreenController.userDetails.images!;

                List<BasicModel> basicList = [];
                basicList = homeScreenController.setBasicListFunction();

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
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            singleItem.images![0].imageUrl),
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
                                  ).commonOnlyPadding(top: 5.h)
                                : Container(
                                    height: homeScreenController
                                                .physicalDeviceHeight <
                                            2200
                                        ? Get.height * 0.75
                                        : Get.height * 0.82,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor2,
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image:
                                            AssetImage(AppImages.swiper1Image),
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
                                        color: Colors.black12, blurRadius: 5),
                                  ],
                                ),
                              ),
                            ),

                            // User name, age module
                            Positioned(
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '${singleItem.name}, ',
                                      style: TextStyleConfig.textStyle(
                                        textColor: AppColors.whiteColor2,
                                        fontSize: 21.sp,
                                        fontFamily:
                                            FontFamilyText.sFProDisplaySemibold,
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
                                        singleItem.verified == "0"
                                            ? WidgetSpan(
                                                child: SizedBox(width: 1.w))
                                            : const WidgetSpan(
                                                child: SizedBox()),
                                        singleItem.verified == "0"
                                            ? WidgetSpan(
                                                child: Image.asset(
                                                  AppImages.rightImage,
                                                  height: 22,
                                                  width: 22,
                                                  fit: BoxFit.fill,
                                                ).commonOnlyPadding(bottom: 5),
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
                                "${homeScreenController.userDetails.bio}",
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
                              LikerBasicInFormationModule(basicList: basicList),
                              //

                              // Interest Module
                              interestList.isEmpty
                                  ? Container()
                                  : SizedBox(height: 4.h),
                              interestList.isEmpty
                                  ? Container()
                                  : LikerInterestsInformationModule(
                                      interestList: interestList),
                              //

                              // Language Module
                              languageList.isEmpty
                                  ? Container()
                                  : SizedBox(height: 4.h),
                              languageList.isEmpty
                                  ? Container()
                                  : LikerLanguagesInformationModule(
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
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          singleItem.images![1].imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, obj, st) {
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
                                          style: TextStyleConfig.textStyle(
                                            fontFamily: FontFamilyText
                                                .sFProDisplaySemibold,
                                            textColor: AppColors.grey300Color,
                                            //fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Container(
                                          width: Get.width,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: AppColors.grey400Color,
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            singleItem.prompts![0].answer,
                                            textAlign: TextAlign.center,
                                            style: TextStyleConfig.textStyle(
                                              fontFamily: FontFamilyText
                                                  .sFProDisplaySemibold,
                                              textColor: AppColors.grey600Color,
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
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 2,
                                imageShowIndex: 2,
                              ),

                              // User 4th Image Show module
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 3,
                                imageShowIndex: 3,
                              ),

                              // User 5th Image Show module
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 4,
                                imageShowIndex: 4,
                              ),

                              // User 6th Image Show module
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 5,
                                imageShowIndex: 5,
                              ),

                              // User 7th Image Show module
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 6,
                                imageShowIndex: 6,
                              ),

                              // User 8th Image Show module
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 7,
                                imageShowIndex: 7,
                              ),

                              // User 9th Image Show module
                              LikerUserImageShowModule(
                                userImagesList: userImagesList,
                                imageListIndex: 8,
                                imageShowIndex: 8,
                              ),
                              //

                              SizedBox(height: 3.h),

                              // Location Module
                              LikerLocationInformationModule(
                                  singleItem: singleItem),
                              //

                              SizedBox(height: 4.h),

                              // Super Love Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      homeScreenController.cardController.next(
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
                                      homeScreenController.cardController.next(
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
                                      homeScreenController.cardController.next(
                                        swipeDirection: SwipeDirection.right,
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

class LikerBasicInFormationModule extends StatelessWidget {
  List<BasicModel> basicList;

  LikerBasicInFormationModule({super.key, required this.basicList});

  final homeScreenController = Get.find<LikerDetailsScreenController>();

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
                transform: Matrix4.identity()..scale(0.93),
                child: ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 9.0,
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

class LikerInterestsInformationModule extends StatelessWidget {
  List<Interest> interestList;

  LikerInterestsInformationModule({super.key, required this.interestList});

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

class LikerLanguagesInformationModule extends StatelessWidget {
  List<String> languageList;

  LikerLanguagesInformationModule({super.key, required this.languageList});

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

class LikerUserImageShowModule extends StatelessWidget {
  List<UserImage> userImagesList;
  final int imageListIndex;
  final int imageShowIndex;

  LikerUserImageShowModule(
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

class LikerLocationInformationModule extends StatelessWidget {
  UserDetails singleItem;

  LikerLocationInformationModule({super.key, required this.singleItem});

  final homeScreenController = Get.find<LikerDetailsScreenController>();

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
              return (singleItem.country == '' && index == 0) ||
                      (singleItem.homeTown == '' && index == 1)
                  ? const SizedBox()
                  : Transform(
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

// class LikerCardSwipeModule extends StatelessWidget {
//   LikerCardSwipeModule({Key? key}) : super(key: key);
//   final likerDetailsScreenController = Get.find<LikerDetailsScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.bottomCenter,
//           clipBehavior: Clip.none,
//           children: [
//             // Container(
//             //   height: 56.h,
//             //   decoration: const BoxDecoration(
//             //     image: DecorationImage(
//             //       image: AssetImage(
//             //         AppImages.lightorange1,
//             //       ),
//             //       fit: BoxFit.fill,
//             //     ),
//             //   ),
//             // ).commonSymmetricPadding(horizontal: 16.w),
//             /*Container(
//               height: 53.h,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                     AppImages.lightorange2,
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ).commonSymmetricPadding(horizontal: 8.w),*/
//             SizedBox(
//               height: 50.h,
//               child: SwipableStack(
//                 allowVerticalSwipe: false,
//                 swipeAnchor: SwipeAnchor.bottom,
//                 cancelAnimationCurve: Curves.bounceIn,
//                 onSwipeCompleted: (index, swipeDirection) async {
//                   if(swipeDirection == SwipeDirection.right) {
//                     await likerDetailsScreenController.superLoveProfileFunction(
//                       likedId: "${likerDetailsScreenController.userDetails.id}",
//                       likeType: LikeType.like,
//                     );
//                   } else if(swipeDirection == SwipeDirection.up) {
//                     await likerDetailsScreenController.superLoveProfileFunction(
//                       likedId: "${likerDetailsScreenController.userDetails.id}",
//                       likeType: LikeType.super_love,
//                     );
//                   } else if(swipeDirection == SwipeDirection.left) {
//                     //todo - when user swipe left
//                   }
//                 },
//                 overlayBuilder: (context, properties) {
//                   final opacity = min(properties.swipeProgress, 1.0);
//                   final isRight =
//                       properties.direction == SwipeDirection.right;
//
//                   return Container(
//                     decoration:
//                     const BoxDecoration(color: Colors.white24),
//                     child: Opacity(
//                       opacity: opacity,
//                       child: Center(
//                         child: isRight
//                             ? const Icon(
//                           Icons.favorite,
//                           color: AppColors.lightOrangeColor,
//                           size: 70,
//                         )
//                             : const Icon(
//                           Icons.close_rounded,
//                           color: AppColors.whiteColor,
//                           size: 70,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 controller: likerDetailsScreenController.cardController,
//                 itemCount: 1, // Only single user data
//                 builder: (context, sp) {
//                   // MatchPersonData singleItem = homeScreenController.matchesList[sp.index];
//
//                   return Image.asset(
//                     AppImages.swiper1Image,
//                     width: double.infinity,
//                     fit: BoxFit.fill,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 1.5.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Cancel Button
//             IconButton(
//               onPressed: () {
//                 //todo - when user swipe left
//                 // homeScreenController.cardController.next(
//                 //   swipeDirection: SwipeDirection.left,
//                 //   duration: const Duration(milliseconds: 600),
//                 // );
//               },
//               icon: Image.asset(AppImages.cancelImage),
//             ),
//
//             // Star Button
//             IconButton(
//               onPressed: () async {
//                 await likerDetailsScreenController.superLoveProfileFunction(
//                   likedId: "${likerDetailsScreenController.userDetails.id}",
//                   likeType: LikeType.super_love,
//                 );
//               },
//               icon: Image.asset(AppImages.starImage),
//             ),
//
//             // Like Button
//             IconButton(
//               onPressed: () async {
//                 await likerDetailsScreenController.superLoveProfileFunction(
//                   likedId: "${likerDetailsScreenController.userDetails.id}",
//                   likeType: LikeType.like,
//                 );
//               },
//               icon: Image.asset(AppImages.likeImage),
//             ),
//           ],
//         ).commonOnlyPadding(left: 15.w, right: 15.w),
//         SizedBox(height: 2.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '${likerDetailsScreenController.userDetails.name}, ${likerDetailsScreenController.userDetails.age}',
//               style: TextStyleConfig.textStyle(
//                 textColor: AppColors.grey800Color,
//                 fontSize: 18.sp,
//                 fontFamily: FontFamilyText.sFProDisplaySemibold,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: 1.w),
//             Image.asset(AppImages.rightImage),
//           ],
//         ),
//         SizedBox(height: 1.h),
//         RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: "${likerDetailsScreenController.userDetails.work} ",
//                 style: TextStyleConfig.textStyle(
//                   textColor: AppColors.grey600Color,
//                   fontSize: 16,
//                   fontFamily: FontFamilyText.sFProDisplayRegular,
//                   // fontWeight: FontWeight.normal,
//                 ),
//               ),
//               WidgetSpan(
//                 child: Image.asset(AppImages.location2Image, height: 2.h),
//               ),
//               TextSpan(
//                 text:
//                 " 10 miles Feminist. Cats. Other Stuff that's mildly interesting",
//                 style: TextStyleConfig.textStyle(
//                   textColor: AppColors.grey600Color,
//                   fontSize: 16,
//                   fontFamily: FontFamilyText.sFProDisplayRegular,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 3.h),
//         Container(
//           height: 56.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             image: const DecorationImage(
//               image: AssetImage(
//                 AppImages.swiper1Image,
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SizedBox(height: 3.h),
//         Row(
//           children: [
//             Text(
//               AppMessages.aboutMe,
//               style: TextStyleConfig.textStyle(
//                 fontSize: 16.sp,
//                 fontFamily: FontFamilyText.sFProDisplaySemibold,
//                 textColor: AppColors.grey800Color,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 0.5.h),
//         Row(
//           children: [
//             Text(
//               "${likerDetailsScreenController.userDetails.bio}",
//               style: TextStyleConfig.textStyle(
//                 fontSize: 13.sp,
//                 fontFamily: FontFamilyText.sFProDisplaySemibold,
//                 textColor: AppColors.grey600Color,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 4.h),
//         LikerBasicInFormationModule(),
//         SizedBox(height: 4.h),
//         LikerInterestsInformationModule(),
//         SizedBox(height: 7.h),
//         Container(
//           height: 56.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             image: const DecorationImage(
//               image: AssetImage(
//                 AppImages.swiper1Image,
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SizedBox(height: 5.h),
//         LikerLanguagesInformationModule(),
//         SizedBox(height: 7.h),
//         Container(
//           height: 56.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             image: const DecorationImage(
//               image: AssetImage(
//                 AppImages.swiper1Image,
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SizedBox(height: 5.h),
//         LikerLocationInformationModule(),
//       ],
//     );
//   }
// }
//
//
// class LikerBasicInFormationModule extends StatelessWidget {
//   LikerBasicInFormationModule({super.key});
//
//   final likerDetailsScreenController = Get.find<LikerDetailsScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               AppMessages.basics,
//               style: TextStyleConfig.textStyle(
//                 fontSize: 16.sp,
//                 fontFamily: FontFamilyText.sFProDisplayBold,
//                 textColor: AppColors.grey800Color,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 2.h),
//         Wrap(
//           spacing: 3.0,
//           children: List.generate(
//             7,
//                 (int index) {
//               return Transform(
//                 transform: Matrix4.identity()..scale(0.9),
//                 child: ChoiceChip(
//                   avatar: const CircleAvatar(
//                     backgroundImage: AssetImage(AppImages.ballImage),
//                   ).commonOnlyPadding(left: 2),
//                   label: Text(
//                     'Socially',
//                     style: TextStyleConfig.textStyle(
//                       fontFamily: FontFamilyText.sFProDisplaySemibold,
//                       textColor: AppColors.grey600Color,
//                       fontSize: 16,
//                     ),
//                   ),
//                   selected: likerDetailsScreenController.selected.value,
//                   selectedColor: AppColors.darkOrangeColor,
//                   backgroundColor: Colors.white,
//                   shape: const StadiumBorder(
//                     side: BorderSide(
//                       color: AppColors.grey400Color,
//                       width: 1.5,
//                     ),
//                   ),
//                   onSelected: (bool value) {},
//                 ),
//               );
//             },
//           ).toList(),
//         )
//       ],
//     );
//   }
// }
//
// class LikerInterestsInformationModule extends StatelessWidget {
//   LikerInterestsInformationModule({super.key});
//
//   final likerDetailsScreenController = Get.find<LikerDetailsScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               AppMessages.interests,
//               style: TextStyleConfig.textStyle(
//                 fontSize: 16.sp,
//                 fontFamily: FontFamilyText.sFProDisplayBold,
//                 textColor: AppColors.grey800Color,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 2.h),
//         likerDetailsScreenController.userDetails.interest!.isEmpty
//         ? Container()
//         : Wrap(
//           spacing: 3.0,
//           children: List.generate(
//             likerDetailsScreenController.userDetails.interest!.length,
//                 (int index) {
//               return Transform(
//                 transform: Matrix4.identity()..scale(0.9),
//                 child: ChoiceChip(
//                   avatar: const CircleAvatar(
//                     backgroundImage: AssetImage(AppImages.ballImage),
//                   ).commonOnlyPadding(left: 2),
//                   label: Text(
//                     likerDetailsScreenController.userDetails.interest![index].name,
//                     style: TextStyleConfig.textStyle(
//                       fontFamily: FontFamilyText.sFProDisplaySemibold,
//                       textColor: AppColors.grey600Color,
//                       fontSize: 16,
//                     ),
//                   ),
//                   selected: likerDetailsScreenController.selected.value,
//                   selectedColor: AppColors.darkOrangeColor,
//                   backgroundColor: Colors.white,
//                   shape: const StadiumBorder(
//                     side: BorderSide(
//                       color: AppColors.grey400Color,
//                       width: 1.5,
//                     ),
//                   ),
//                   onSelected: (bool value) {},
//                 ),
//               );
//             },
//           ).toList(),
//         )
//       ],
//     );
//   }
// }
//
// class LikerLanguagesInformationModule extends StatelessWidget {
//   LikerLanguagesInformationModule({super.key});
//
//   final likerDetailsScreenController = Get.find<LikerDetailsScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Text(
//               AppMessages.languagesIKnow,
//               style: TextStyleConfig.textStyle(
//                 fontSize: 16.sp,
//                 fontFamily: FontFamilyText.sFProDisplayBold,
//                 textColor: AppColors.grey800Color,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 2.h),
//         Wrap(
//           spacing: 3.0,
//           children: List.generate(
//             3,
//                 (int index) {
//               return Transform(
//                 transform: Matrix4.identity()..scale(0.9),
//                 child: ChoiceChip(
//                   avatar: const CircleAvatar(
//                     backgroundImage: AssetImage(AppImages.ballImage),
//                   ).commonOnlyPadding(left: 2),
//                   label: Text(
//                     'Japanese',
//                     style: TextStyleConfig.textStyle(
//                       fontFamily: FontFamilyText.sFProDisplaySemibold,
//                       textColor: AppColors.grey600Color,
//                       fontSize: 16,
//                     ),
//                   ),
//                   selected: likerDetailsScreenController.selected.value,
//                   selectedColor: AppColors.darkOrangeColor,
//                   backgroundColor: Colors.white,
//                   shape: const StadiumBorder(
//                     side: BorderSide(
//                       color: AppColors.grey400Color,
//                       width: 1.5,
//                     ),
//                   ),
//                   onSelected: (bool value) {},
//                 ),
//               );
//             },
//           ).toList(),
//         )
//       ],
//     );
//   }
// }
//
// class LikerLocationInformationModule extends StatelessWidget {
//   LikerLocationInformationModule({super.key});
//
//   final likerDetailsScreenController = Get.find<LikerDetailsScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Image.asset(
//               AppImages.location2Image,
//               height: 3.h,
//               width: 3.h,
//             ),
//             SizedBox(width: 1.w),
//             Text(
//               AppMessages.locationText,
//               style: TextStyleConfig.textStyle(
//                 fontSize: 16.sp,
//                 fontFamily: FontFamilyText.sFProDisplayBold,
//                 textColor: AppColors.grey800Color,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 2.h),
//         Row(
//           children: [
//             Text(
//               textAlign: TextAlign.start,
//               "New South Wales, Sydney \n3 km away",
//               style: TextStyleConfig.textStyle(
//                 fontFamily: FontFamilyText.sFProDisplaySemibold,
//                 textColor: AppColors.grey600Color,
//                 fontSize: 12.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 2.h),
//         Wrap(
//           spacing: 3.0,
//           children: List.generate(
//             2,
//                 (int index) {
//               return Transform(
//                 transform: Matrix4.identity()..scale(0.9),
//                 child: ChoiceChip(
//                   avatar: const CircleAvatar(
//                     backgroundImage: AssetImage(AppImages.ballImage),
//                   ).commonOnlyPadding(left: 2),
//                   label: Text(
//                     'Live in New  ',
//                     style: TextStyleConfig.textStyle(
//                       fontFamily: FontFamilyText.sFProDisplaySemibold,
//                       textColor: AppColors.grey600Color,
//                       fontSize: 16,
//                     ),
//                   ),
//                   selected: likerDetailsScreenController.selected.value,
//                   selectedColor: AppColors.darkOrangeColor,
//                   backgroundColor: Colors.white,
//                   shape: const StadiumBorder(
//                     side: BorderSide(
//                       color: AppColors.grey400Color,
//                       width: 1.5,
//                     ),
//                   ),
//                   onSelected: (bool value) {},
//                 ),
//               );
//             },
//           ).toList(),
//         )
//       ],
//     );
//   }
// }
