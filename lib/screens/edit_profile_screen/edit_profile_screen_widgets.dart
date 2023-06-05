// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/model/profile_screen_models/logged_in_user_details_model.dart';
import 'package:dater/screens/edit_profile_screen/edit_enterests.dart';
import 'package:dater/screens/language_select_screen/language_select_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:sizer/sizer.dart';

import '../../common_modules/custom_button.dart';
import '../../constants/enums.dart';
import '../../controller/edit_profile_screen_controller.dart';
import '../../model/profile_screen_models/upload_image_model.dart';
import '../looking_for_screen/looking_for_screen.dart';
import '../my_basic_education_screen/my_basic_education_screen.dart';
import '../my_basic_gender_screen/my_basic_gender_screen.dart';
import '../my_basic_home_town_screen/my_basic_home_town_screen.dart';
import '../my_basic_work_screen/my_basic_work_screen.dart';
import '../politics_screen/politics_screen.dart';
import '../profile_prompts_screens/profile_prompts_screen/profile_prompts_screen.dart';
import '../religion_screen/religion_screen.dart';
import '../star_sign_screen/star_sign_screen.dart';

class ProfileStrengthModule extends StatelessWidget {
  ProfileStrengthModule({Key? key}) : super(key: key);
  final editProfileScreenController = Get.find<EditProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppMessages.profileStrength,
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplaySemibold,
            textColor: AppColors.grey800Color,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 2.5.h),
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.grey300Color,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              "${editProfileScreenController.userPercentage}% Complete",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.lightOrangeColor,
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}

class ReorderableGridViewModule extends StatelessWidget {
  ReorderableGridViewModule({super.key});

  final editProfileScreenController = Get.find<EditProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => editProfileScreenController.isLoading.value
          ? const CustomLoader()
          : ReorderableGridView.builder(
              itemCount: editProfileScreenController.captureImageList.length < 9
                  ? editProfileScreenController.captureImageList.length + 1
                  : editProfileScreenController.captureImageList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: ((oldIndex, newIndex) {
                log('oldIndex : $oldIndex');
                log('newIndex : $newIndex');
                editProfileScreenController.isLoading(true);

                /// When you reorder the user images that time calling this
                if (editProfileScreenController.captureImageList.length < 9) {
                  if (oldIndex !=
                          editProfileScreenController.captureImageList.length &&
                      newIndex !=
                          editProfileScreenController.captureImageList.length) {
                    UploadUserImage path = editProfileScreenController
                        .captureImageList
                        .removeAt(oldIndex);
                    editProfileScreenController.captureImageList
                        .insert(newIndex, path);
                  }
                } else {
                  UploadUserImage path = editProfileScreenController
                      .captureImageList
                      .removeAt(oldIndex);
                  editProfileScreenController.captureImageList
                      .insert(newIndex, path);
                }
                editProfileScreenController.isLoading(false);
              }),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, i) {
                int lastNumber =
                    editProfileScreenController.captureImageList.length;
                // log('i : $i');
                // log('lastNumber : $lastNumber');

                return lastNumber != i
                    ? Container(
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        key: ValueKey(
                            editProfileScreenController.captureImageList),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              editProfileScreenController.getImageFromGallery(),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              editProfileScreenController.captureImageList[i]
                                          .isImageFromNetwork ==
                                      false
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey200Color,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(
                                              editProfileScreenController
                                                  .captureImageList[i].imageUrl,
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.grey200Color,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            editProfileScreenController
                                                .captureImageList[i].imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              GestureDetector(
                                  onTap: () {
                                    openImageOptionDialog(i);
                                  },
                                  child: const Icon(
                                    Icons.more_vert_sharp,
                                    color: AppColors.blackColor,
                                    size: 30,
                                  )).commonOnlyPadding(top: 10),
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        alignment: Alignment.bottomRight,
                        key: ValueKey(
                            editProfileScreenController.captureImageList),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.grey200Color,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ).commonOnlyPadding(left: 10, top: 10),
                          GestureDetector(
                            onTap: () async => await editProfileScreenController
                                .getImageFromGallery(),
                            child: Image.asset(
                              AppImages.add,
                              height: 20,
                              width: 20,
                            ).commonOnlyPadding(bottom: 10, right: 10),
                          )
                        ],
                      );
              },
            ),
    );
  }

  openImageOptionDialog(int i) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 50,
          actions: [
            SizedBox(height: 2.h),
            ButtonCustom(
              backgroundColor: AppColors.lightOrangeColor,
              textColor: AppColors.whiteColor,
              textFontFamily: FontFamilyText.sFProDisplayBold,
              textsize: 12.sp,
              onPressed: () async {
                log('Image Id : ${editProfileScreenController.captureImageList[i].id}');
                await editProfileScreenController.setUserCoverImageFunction(
                  editProfileScreenController.captureImageList[i].id,
                );
              },
              text: "Make as cover",
            ).commonSymmetricPadding(horizontal: 30),
            SizedBox(height: 2.h),
            ButtonCustom(
              backgroundColor: AppColors.lightOrangeColor,
              textColor: AppColors.whiteColor,
              textFontFamily: FontFamilyText.sFProDisplayBold,
              textsize: 12.sp,
              onPressed: () async {
                // If image from network then call api
                if (editProfileScreenController.captureImageList[i].id != "") {
                  await editProfileScreenController.deleteUserImagesFunction(
                    id: editProfileScreenController.captureImageList[i].id,
                    index: i,
                  );
                  Get.back();
                } else {
                  /// Local image remove only from local ist only
                  editProfileScreenController.deleteUserImageFunction(i);
                  Get.back();
                }
              },
              text: "Delete",
            ).commonSymmetricPadding(horizontal: 30),
            SizedBox(height: 2.h),
          ],
        );
      },
    );
  }
}

class EditProfileScreenWidgets extends StatelessWidget {
  EditProfileScreenWidgets({super.key});

  final editProfileScreenController = Get.find<EditProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   AppMessages.holdAndDragText,
        //   style: TextStyleConfig.textStyle(
        //     fontFamily: FontFamilyText.sFProDisplayRegular,
        //     textColor: AppColors.grey600Color,
        //     fontSize: 14.sp,
        //   ),
        // ),
        // SizedBox(height: 4.h),

        ///name
        SizedBox(height: 4.h),
        //TODO: add edit name api call
        Row(
          children: [
            Text(
              AppMessages.myName,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey800Color,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.grey300Color,
              width: 3,
            ),
          ),
          child: TextFormField(
            cursorColor: AppColors.lightOrangeColor,
            maxLines: 1,
            controller: editProfileScreenController.myNameController,
            onEditingComplete: () async {
              await editProfileScreenController.setUserNameFunction();
            },
            decoration: InputDecoration(
              hintText: "My new name...",
              hintStyle: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 15.sp,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            textAlign: TextAlign.center,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 15.sp,
              textColor: AppColors.grey600Color,
            ),
          ),
        ),
        ButtonCustom(
                // fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textFontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.whiteColor2,
                backgroundColor: AppColors.darkOrangeColor,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                size: const Size(18.0, 18.0),
                text: 'save name',
                onPressed: () async {
                  // await editProfileScreenController.setUserBioFunction();
                })
            .commonOnlyPadding(top: 1.h),

        /// My Bio
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              AppMessages.myBio,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey800Color,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.grey300Color,
              width: 3,
            ),
          ),
          child: TextFormField(
            cursorColor: AppColors.lightOrangeColor,
            maxLines: 1,
            controller: editProfileScreenController.myBioController,
            onEditingComplete: () async {
              // printAll('done', name: 'bio');
              await editProfileScreenController.setUserBioFunction();
            },
            decoration: InputDecoration(
              hintText: "A little bit about you ...",
              hintStyle: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 15.sp,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            textAlign: TextAlign.center,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 15.sp,
              textColor: AppColors.grey600Color,
            ),
          ),
        ),
        ButtonCustom(
            // fontWeight: FontWeight.bold,
            textsize: 14.sp,
            textFontFamily: FontFamilyText.sFProDisplayBold,
            textColor: AppColors.whiteColor2,
            backgroundColor: AppColors.darkOrangeColor,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            size: const Size(18.0, 18.0),
            text: 'save bio',
            onPressed: () async {
              await editProfileScreenController.setUserBioFunction();
            }).commonOnlyPadding(top: 1.h),

        /// My basics
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              AppMessages.myBasics,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey800Color,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        // Work Module
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => MyBasicWorkScreen(),
              arguments: [editProfileScreenController.work], //todo
            )!
                .then((value) async {
              await editProfileScreenController.getMyBasicWorkValueFromPrefs();
            });
          },
          image: AppImages.workImage,
          lableText: "Work",
          text: editProfileScreenController.work,
        ),
        // Education Module
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => MyBasicEducationScreen(),
              arguments: [editProfileScreenController.education],
            )!
                .then((value) async {
              await editProfileScreenController
                  .getMyBasicEducationValueFromPrefs();
            });
          },
          image: AppImages.educationImage,
          lableText: "Education",
          text: editProfileScreenController.education == ""
              ? 'Add'
              : editProfileScreenController.education,
        ),
        // Gender Module
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => MyBasicGenderScreen(),
              arguments: [editProfileScreenController.gender],
            )!
                .then((value) async {
              await editProfileScreenController
                  .getMyBasicGenderValueFromPrefs();
            });
          },
          image: AppImages.genderImage,
          lableText: "Gender",
          text: editProfileScreenController.gender == ''
              ? 'Add'
              : editProfileScreenController.gender,
        ),

        // Home Town Module
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => MyBasicHomeTownScreen(),
              arguments: [editProfileScreenController.homeTown],
            )!
                .then((value) async {
              await editProfileScreenController
                  .getMyBasicHomeTownValueFromPrefs();
            });
          },
          image: AppImages.homeTownImage,
          lableText: "Hometown",
          text: editProfileScreenController.homeTown == ''
              ? 'Add'
              : editProfileScreenController.homeTown,
        ),

        // Looking For Module
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => LookingForScreen(),
              arguments: [editProfileScreenController.lookingFor],
            )!
                .then((value) async {
              await editProfileScreenController
                  .getMyBasicLookingForValueFromPrefs();
            });
          },
          image: AppImages.lookingForImage,
          lableText: "Looking for",
          text: editProfileScreenController.lookingFor == ''
              ? 'Add'
              : editProfileScreenController.lookingFor,
        ),

        /// Height Module
        SizedBox(height: 1.h),
        Row(
          children: [
            Image.asset(AppImages.heightImage),
            SizedBox(width: 3.w),
            Text(
              '${AppMessages.height}:',
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(width: 1.w),
            Text(
              textAlign: TextAlign.center,
              "${editProfileScreenController.endVal.value.toStringAsFixed(0)} cm",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 13.sp,
              ),
            ),
            // SizedBox(width: 15.w),
            const Spacer(),
            ButtonCustom(
                // fontWeight: FontWeight.bold,
                textsize: 9.sp,
                textFontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.whiteColor2,
                backgroundColor: AppColors.darkOrangeColor,
                // padding: const EdgeInsets.symmetric(horizontal: 4),
                size: const Size(3.0, 3.0),
                text: 'save height',
                onPressed: () async {
                  await editProfileScreenController.setUserHeightFunction();
                }),
          ],
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Row(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: Get.width / 1.2,
                      child: SliderTheme(
                        data: const SliderThemeData(trackHeight: 2),
                        child: Slider(
                          min: 120.0,
                          max: 220.0,
                          activeColor: AppColors.lightOrangeColor,
                          inactiveColor: AppColors.darkGreyColor,
                          value: editProfileScreenController.endVal.value,
                          onChanged: (double value) {
                            editProfileScreenController.endVal.value = value;
                            // await editProfileScreenController
                            //     .setUserHeightFunction();
                            editProfileScreenController.loadUI();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
        // Exercise
        SizedBox(height: 1.h),
        FilterRowmodule(
          image: AppImages.exerciseImage,
          lableText: "Exercise",
          text1: "No",
          text2: "Sometimes",
          text3: "Yes",
          text4: "hidden",
          containerColor1:
              editProfileScreenController.exerciseValue == MoreAboutMe.no
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor2:
              editProfileScreenController.exerciseValue == MoreAboutMe.sometimes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor3:
              editProfileScreenController.exerciseValue == MoreAboutMe.yes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor4:
              editProfileScreenController.exerciseValue == MoreAboutMe.hidden
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          gesOnTap1: () {
            editProfileScreenController.exerciseValue = MoreAboutMe.no;
            editProfileScreenController
                .setExerciseFunction(editProfileScreenController.exerciseValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap2: () {
            editProfileScreenController.exerciseValue = MoreAboutMe.sometimes;
            editProfileScreenController
                .setExerciseFunction(editProfileScreenController.exerciseValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap3: () {
            editProfileScreenController.exerciseValue = MoreAboutMe.yes;
            editProfileScreenController
                .setExerciseFunction(editProfileScreenController.exerciseValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap4: () {
            editProfileScreenController.exerciseValue = MoreAboutMe.hidden;
            editProfileScreenController
                .setExerciseFunction(editProfileScreenController.exerciseValue);
            editProfileScreenController.loadUI();
          },
        ),
        // Drinking
        FilterRowmodule(
          image: AppImages.drinkingImage,
          lableText: "Drinking",
          text1: "No",
          text2: "Socially",
          text3: "Yes",
          text4: "hidden",
          containerColor1:
              editProfileScreenController.drinkingValue == MoreAboutMe.no
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor2:
              editProfileScreenController.drinkingValue == MoreAboutMe.sometimes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor3:
              editProfileScreenController.drinkingValue == MoreAboutMe.yes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor4:
              editProfileScreenController.drinkingValue == MoreAboutMe.hidden
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          gesOnTap1: () {
            editProfileScreenController.drinkingValue = MoreAboutMe.no;
            editProfileScreenController
                .setDrinkingFunction(editProfileScreenController.drinkingValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap2: () {
            editProfileScreenController.drinkingValue = MoreAboutMe.sometimes;
            editProfileScreenController
                .setDrinkingFunction(editProfileScreenController.drinkingValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap3: () {
            editProfileScreenController.drinkingValue = MoreAboutMe.yes;
            editProfileScreenController
                .setDrinkingFunction(editProfileScreenController.drinkingValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap4: () {
            editProfileScreenController.drinkingValue = MoreAboutMe.hidden;
            editProfileScreenController
                .setDrinkingFunction(editProfileScreenController.drinkingValue);
            editProfileScreenController.loadUI();
          },
        ),
        // Smoking
        FilterRowmodule(
          image: AppImages.smokingImage,
          lableText: "Smoking",
          text1: "No",
          text2: "Socially",
          text3: "Yes",
          text4: "hidden",
          containerColor1:
              editProfileScreenController.smokingValue == MoreAboutMe.no
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor2:
              editProfileScreenController.smokingValue == MoreAboutMe.sometimes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor3:
              editProfileScreenController.smokingValue == MoreAboutMe.yes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor4:
              editProfileScreenController.smokingValue == MoreAboutMe.hidden
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          gesOnTap1: () {
            editProfileScreenController.smokingValue = MoreAboutMe.no;
            editProfileScreenController
                .setSmokingFunction(editProfileScreenController.smokingValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap2: () {
            editProfileScreenController.smokingValue = MoreAboutMe.sometimes;
            editProfileScreenController
                .setSmokingFunction(editProfileScreenController.smokingValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap3: () {
            editProfileScreenController.smokingValue = MoreAboutMe.yes;
            editProfileScreenController
                .setSmokingFunction(editProfileScreenController.smokingValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap4: () {
            editProfileScreenController.smokingValue = MoreAboutMe.hidden;
            editProfileScreenController
                .setSmokingFunction(editProfileScreenController.smokingValue);
            editProfileScreenController.loadUI();
          },
        ),
        // Kids
        FilterRowmodule(
          image: AppImages.kidsImage,
          lableText: "Kids",
          text1: "No",
          text2: "someday",
          text3: "Yes",
          text4: "hidden",
          containerColor1:
              editProfileScreenController.kidsValue == MoreAboutMe.no
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor2:
              editProfileScreenController.kidsValue == MoreAboutMe.sometimes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor3:
              editProfileScreenController.kidsValue == MoreAboutMe.yes
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          containerColor4:
              editProfileScreenController.kidsValue == MoreAboutMe.hidden
                  ? AppColors.lightOrangeColor
                  : AppColors.grey500Color,
          gesOnTap1: () {
            editProfileScreenController.kidsValue = MoreAboutMe.no;
            editProfileScreenController
                .setKidsFunction(editProfileScreenController.kidsValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap2: () {
            editProfileScreenController.kidsValue = MoreAboutMe.sometimes;
            editProfileScreenController
                .setKidsFunction(editProfileScreenController.kidsValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap3: () {
            editProfileScreenController.kidsValue = MoreAboutMe.yes;
            editProfileScreenController
                .setKidsFunction(editProfileScreenController.kidsValue);
            editProfileScreenController.loadUI();
          },
          gesOnTap4: () {
            editProfileScreenController.kidsValue = MoreAboutMe.hidden;
            editProfileScreenController
                .setKidsFunction(editProfileScreenController.kidsValue);
            editProfileScreenController.loadUI();
          },
        ),
        // Star Sign
        SizedBox(height: 1.h),

        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => StarSignScreen(),
              arguments: [editProfileScreenController.starSign],
            )!
                .then((value) async {
              await editProfileScreenController.getStarSignValueFromPrefs();
            });
          },
          image: AppImages.starsignImage,
          lableText: "Star Sign",
          text: editProfileScreenController.starSign == ''
              ? 'Add'
              : editProfileScreenController.starSign,
        ),
        // Politics
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => PoliticsScreen(),
              arguments: [editProfileScreenController.politics],
            )!
                .then((value) async {
              await editProfileScreenController.getPoliticsValueFromPrefs();
            });
          },
          image: AppImages.politicsImage,
          lableText: "Politics",
          text: editProfileScreenController.politics == ''
              ? 'Add'
              : editProfileScreenController.politics,
        ),
        // Religion
        MyBasicRowmodule(
          gesOnTap: () {
            Get.to(
              () => ReligionScreen(),
              arguments: [editProfileScreenController.religion],
            )!
                .then((value) async {
              await editProfileScreenController.getReligionValueFromPrefs();
            });
          },
          image: AppImages.religionImage,
          lableText: "Religion",
          text: editProfileScreenController.religion == ''
              ? 'Add'
              : editProfileScreenController.religion,
        ),

        /// My Interest Module
        SizedBox(height: 5.h),
        Row(
          children: [
            Text(
              AppMessages.myInterests,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey800Color,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Get specific about the things you love",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 12.sp,
              ),
            )
          ],
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () {
            Get.to(
              EditInterests(),
            );
          },
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.grey300Color,
                width: 3,
              ),
            ),
            child: Wrap(
              // spacing: 3.0,
              children: List.generate(
                editProfileScreenController.interestList.length,
                (int index) {
                  return Transform(
                    transform: Matrix4.identity()..scale(0.95),
                    child: ChoiceChip(
                      avatar: editProfileScreenController
                                  .interestList[index].image !=
                              AppImages.ballImage
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  editProfileScreenController
                                      .interestList[index].image),
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(
                                  editProfileScreenController
                                      .interestList[index].image),
                            ),
                      label: Text(
                        editProfileScreenController.interestList[index].name,
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
                  ).commonSymmetricPadding(horizontal: 1);
                },
              ).toList(),
            ),
          ),
        ),

        /// Language Box
        SizedBox(height: 5.h),
        Row(
          children: [
            Text(
              AppMessages.languages,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey800Color,
                fontSize: 16.sp,
              ),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "Choose the languages you know",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 12.sp,
              ),
            )
          ],
        ),
        SizedBox(height: 3.h),
        GestureDetector(
          onTap: () {
            Get.to(() => LanguageSelectScreen(),
                    arguments: [editProfileScreenController.languageList])!
                .then((value) async =>
                    await editProfileScreenController.getUserDetailsFunction());
          },
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.grey300Color,
                width: 3,
              ),
            ),
            child: Wrap(
              // spacing: 3.0,
              children: List.generate(
                editProfileScreenController.languageList.length,
                (int index) {
                  bool selected = true;
                  return Transform(
                    transform: Matrix4.identity()..scale(0.9),
                    child: ChoiceChip(
                      avatar: const CircleAvatar(
                        radius: 9.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(AppImages.languageImage),
                      ),
                      label: Text(
                        editProfileScreenController.languageList[index],
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
                  ).commonSymmetricPadding(horizontal: 1);
                },
              ).toList(),
            ),
          ),
        ),

        /// Profile Prompts
        SizedBox(height: 5.h),
        Row(
          children: [
            Text(
              AppMessages.profilePrompts,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplaySemibold,
                textColor: AppColors.grey800Color,
                fontSize: 16.sp,
              ),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "Make your personality stand out from the crowd",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 12.sp,
              ),
            )
          ],
        ),
        SizedBox(height: 2.h),

        editProfileScreenController.promptsList.isNotEmpty
            ? ListView.builder(
                itemCount: editProfileScreenController.promptsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  Prompt singleData =
                      editProfileScreenController.promptsList[i];
                  return GestureDetector(
                    onTap: () => openEditPromptsBottomSheetModule(
                      index: i,
                      singleData: singleData,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.grey300Color,
                          width: 3,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  singleData.question,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleConfig.textStyle(
                                    fontFamily:
                                        FontFamilyText.sFProDisplaySemibold,
                                    textColor: AppColors.blackColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  singleData.answer,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleConfig.textStyle(
                                    fontFamily:
                                        FontFamilyText.sFProDisplaySemibold,
                                    textColor: AppColors.grey700Color,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.grey600Color,
                            size: 15.sp,
                          ),
                          /*IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.grey600Color,
                      ),
                    ),*/
                        ],
                      ).commonAllSidePadding(10),
                    ).commonSymmetricPadding(vertical: 5),
                  );
                },
              )
            : const SizedBox(),

        editProfileScreenController.promptsList.isNotEmpty
            ? SizedBox(height: 0.5.h)
            : const SizedBox(),
        Container(
          // height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.grey300Color,
              width: 3,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: TextFormField(
                    readOnly: editProfileScreenController.onSelected.value
                        ? false
                        : true,
                    controller:
                        editProfileScreenController.profilePromptsController,
                    cursorColor: AppColors.lightOrangeColor,
                    onChanged: (value) async {
                      await editProfileScreenController
                          .setProfilePromptsFunction();
                    },
                    maxLines: 1,
                    maxLength: 65,
                    decoration: InputDecoration(
                      hintText: "Add a question",
                      hintStyle: TextStyleConfig.textStyle(
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        textColor: AppColors.grey600Color,
                        fontSize: 15.sp,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      counterText: "",
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      fontSize: 15.sp,
                      textColor: AppColors.grey600Color,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => ProfilePromptsScreen())!.then((value) async {
                    await editProfileScreenController.getUserDetailsFunction();
                  });
                },
                icon: const Icon(
                  Icons.add_rounded,
                  color: AppColors.grey600Color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openEditPromptsBottomSheetModule(
      {required Prompt singleData, required int index}) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to delete this prompts ?",
                textAlign: TextAlign.center,
                style: TextStyleConfig.textStyle(
                  fontFamily: FontFamilyText.sFProDisplaySemibold,
                  textColor: AppColors.grey800Color,
                  fontSize: 14.sp,
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ButtonCustom(
                      text: AppMessages.no,
                      onPressed: () => Get.back(),
                      textsize: 10.sp,
                    ).commonOnlyPadding(right: 50),
                  ),
                  Expanded(
                    child: ButtonCustom(
                      text: AppMessages.yes,
                      backgroundColor: AppColors.lightOrangeColor,
                      textColor: AppColors.whiteColor,
                      textsize: 10.sp,
                      onPressed: () async => await editProfileScreenController
                          .deletePromptsFunction(
                              index: index, promptsId: singleData.promptId),
                    ).commonOnlyPadding(left: 50),
                  ),
                ],
              ),
            ],
          ).commonAllSidePadding(30),
        ).commonAllSidePadding(20);
      },
    );
  }
}

// ignore: must_be_immutable
class MyBasicRowmodule extends StatelessWidget {
  Function() gesOnTap;
  String lableText;
  String image;
  String text;

  MyBasicRowmodule({
    Key? key,
    required this.gesOnTap,
    required this.lableText,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gesOnTap,
      child: Row(
        children: [
          Image.asset(image),
          SizedBox(width: 3.w),
          Text(
            lableText,
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              textColor: AppColors.grey600Color,
              fontSize: 15.sp,
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.end,
              text,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                fontSize: 14.sp,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.grey600Color,
          ),
        ],
      ),
    ).commonOnlyPadding(bottom: 2.h);
  }
}

class FilterRowmodule extends StatelessWidget {
  String lableText;
  String image;
  String text1;
  String text2;
  String text3;
  String text4;
  Function() gesOnTap1;
  Function() gesOnTap2;
  Function() gesOnTap3;
  Function() gesOnTap4;
  Color containerColor1;
  Color containerColor2;
  Color containerColor3;
  Color containerColor4;

  FilterRowmodule({
    Key? key,
    required this.lableText,
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.gesOnTap1,
    required this.gesOnTap2,
    required this.gesOnTap3,
    required this.gesOnTap4,
    required this.containerColor1,
    required this.containerColor2,
    required this.containerColor3,
    required this.containerColor4,
  }) : super(key: key);
  final editProfileScreenController = Get.find<EditProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
        ),
        SizedBox(width: 1.w),
        Text(
          lableText,
          style: TextStyleConfig.textStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            textColor: AppColors.grey600Color,
            fontSize: 15.sp,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 10.w,
              child: Column(
                children: [
                  Text(
                    text1,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      textColor: AppColors.grey600Color,
                      fontSize: 12.sp,
                    ),
                  ),
                  InkWell(
                    onTap: gesOnTap1,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: containerColor1,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              // width: lableText=='Kids'?28.w:22.w,
              width: 22.w,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text2,
                    textAlign: TextAlign.center,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      textColor: AppColors.grey600Color,
                      fontSize: 12.sp,
                    ),
                  ),
                  InkWell(
                    onTap: gesOnTap2,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: containerColor2,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12.w,
              child: Column(
                children: [
                  Text(
                    text3,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      textColor: AppColors.grey600Color,
                      fontSize: 12.sp,
                    ),
                  ),
                  InkWell(
                    onTap: gesOnTap3,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: containerColor3,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16.w,
              child: Column(
                children: [
                  Text(
                    text4,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      textColor: AppColors.grey600Color,
                      fontSize: 12.sp,
                    ),
                  ),
                  InkWell(
                    onTap: gesOnTap4,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: containerColor4,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ).commonOnlyPadding(bottom: 2.h);
  }
}
