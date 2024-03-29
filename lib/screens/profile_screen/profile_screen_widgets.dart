import 'package:cached_network_image/cached_network_image.dart';
import 'package:dater/screens/settings_screen/settings_screen.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../constants/app_images.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/profile_screen_controller.dart';
import '../../utils/style.dart';
import '../edit_profile_screen/edit_profile_screen.dart';

class ProfileModule extends StatelessWidget {
  ProfileModule({Key? key}) : super(key: key);
  final profileScreenController = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            // color: Colors.red,
            //height: 17.5.h,
            height: 170,
            width: 150,
            child: SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 45,
                  endAngle: 405,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.09,
                    cornerStyle: CornerStyle.bothCurve,
                    color: AppColors.grey700Color,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                        value: profileScreenController.userPercentage.value,
                        width: 0.06,
                        color: AppColors.darkOrangeColor,
                        sizeUnit: GaugeSizeUnit.factor,
                        enableAnimation: true,
                        animationDuration: 100,
                        animationType: AnimationType.linear)
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 10,
              child: profileScreenController.userImages.isEmpty
                  ? Container(
                      height: 130,
                      width: 130,
                      decoration: const BoxDecoration(
                        color: AppColors.grey700Color,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.swiper2Image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: profileScreenController.userImages[0].imageUrl,
                      width: 130,
                      height: 130,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: AppColors.grey700Color,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        return Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: AppColors.grey700Color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.error,
                            color: Colors.white,
                            size:
                                40, // You can adjust the size of the error icon
                          ),
                        );
                      },
                    )),
          Positioned(
            right: 4,
            bottom: 25,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5.0,
                        offset: Offset(-0, 2),
                        color: AppColors.grey800Color)
                  ]),
              child: Text(
                '${profileScreenController.userPercentage.value.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontFamily: FontFamilyText.sFProDisplaySemibold,
                  fontSize: 11,
                ),
              ).commonAllSidePadding(10),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextModule extends StatelessWidget {
  ProfileTextModule({Key? key}) : super(key: key);
  final screenController = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Setting Button & Edit Button Module
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Get.to(() => SettingsScreen()),
              icon: const Icon(
                Icons.settings_outlined,
                color: AppColors.darkOrangeColor,
                size: 30,
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${screenController.userName.value},${screenController.userAge.value} ',
                    style: TextStyleConfig.textStyle(
                      textColor: AppColors.grey800Color,
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                      fontSize: 14.sp,
                    ),
                  ),
                  screenController.userVerified.value == "0"
                      ? WidgetSpan(child: Container())
                      : WidgetSpan(child: Image.asset(AppImages.rightImage))
                ],
              ),
            ),
            IconButton(
                onPressed: () => Get.to(() => EditProfileScreen(),
                            arguments: [screenController.userDetails])!
                        .then((value) async {
                      // await screenController.setDataInUserVariablesFunction();
                      screenController.clearOldUserDataFunction();
                      await screenController.getUserDetailsFunction();
                    }),
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.darkOrangeColor,
                  size: 20,
                ))
          ],
        ),
        // Work Module
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (screenController.userWork.value != 'Add') ...[
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Image.asset(
                        AppImages.workImage,
                        height: 2.h,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 1.w,
                      ),
                    ),
                    TextSpan(
                      text: '${screenController.userWork.value} ',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey800Color,
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
            if (screenController.userEducation.value != 'Add') ...[
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Image.asset(
                        AppImages.educationImage,
                        height: 2.h,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 1.w,
                      ),
                    ),
                    TextSpan(
                      text: '${screenController.userEducation.value} ',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey800Color,
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ],
        ),

        //  basicList.add(
        //         BasicModel(image: AppImages.educationImage, name: userEducation.value));
        screenController.promptsList.isNotEmpty
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "${screenController.promptsList[0].question}${screenController.promptsList[0].answer}",
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey800Color,
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: 2.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Gender: ",
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.grey800Color,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  fontSize: 12.sp,
                ),
              ),
              TextSpan(
                text: screenController.userGender.value,
                style: TextStyleConfig.textStyle(
                  textColor: AppColors.darkOrangeColor,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AboutMeAllModule extends StatelessWidget {
  AboutMeAllModule({Key? key}) : super(key: key);
  final screenController = Get.find<ProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About Me Module
        if (screenController.userBio.value != '') ...[
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              'About me',
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.grey800Color,
                //fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              screenController.userBio.value,
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayRegular,
                textColor: AppColors.grey600Color,
                //fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],

        // My Basic Module

        if (screenController.basicList.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              "Basics",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.grey800Color,
                //fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              spacing: 0.0,
              children: List.generate(
                screenController.basicList.length,
                (int index) {
                  return (screenController.basicList[index].name != "Add" &&
                          screenController.basicList[index].name != "" &&
                          screenController.basicList[index].name != " cm" &&
                          screenController.basicList[index].name != 'hidden')
                      ? Transform(
                          transform: Matrix4.identity()..scale(0.95),
                          child: ChoiceChip(
                            // avatar: CircleAvatar(
                            //   // radius: 9.0,
                            //   backgroundColor: Colors.transparent,
                            //   backgroundImage: AssetImage(
                            //       screenController.basicList[index].image),
                            // ),
                            avatar: Image(
                              height: 35,
                              width: 35,
                              image: AssetImage(
                                screenController.basicList[index].image,
                              ),
                            ),
                            label: Text(
                              screenController.basicList[index].name.trim(),
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
                        ).commonSymmetricPadding(horizontal: 1)
                      : const SizedBox();
                },
              ).toList(),
            ),
          ),
        ],
        // Interest Module
        Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Text(
            "Interests",
            style: TextStyleConfig.textStyle(
              fontFamily: FontFamilyText.sFProDisplayBold,
              textColor: AppColors.grey800Color,
              //fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Wrap(
            // spacing: 3.0,
            children: List.generate(
              screenController.interestList.length,
              (int index) {
                return Transform(
                  transform: Matrix4.identity()..scale(0.95),
                  child: ChoiceChip(
                    avatar: screenController.interestList[index].image !=
                            AppImages.ballImage
                        ? CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                screenController.interestList[index].image),
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage(
                                screenController.interestList[index].image),
                          ),
                    label: Text(
                      screenController.interestList[index].name,
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
        if (screenController.languageList.isNotEmpty) ...[
          SizedBox(height: 2.h),
          // Language Module
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              "Languages I Known",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.grey800Color,
                //fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              // spacing: 1.0,
              children: List.generate(
                screenController.languageList.length,
                (int index) {
                  return Transform(
                    transform: Matrix4.identity()..scale(0.9),
                    child: ChoiceChip(
                      avatar: const CircleAvatar(
                        radius: 9.0,
                        backgroundImage: AssetImage(AppImages.languageImage),
                        backgroundColor: Colors.transparent,
                      ),
                      label: Text(
                        screenController.languageList[index],
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
                  ).commonSymmetricPadding(horizontal: 5);
                },
              ).toList(),
            ),
          ),
          SizedBox(
            height: 1.h,
          )
        ],

        screenController.userImages.length < 2
            ? Container()
            : CachedNetworkImage(
                imageUrl: screenController.userImages[1].imageUrl,
                height: 50.h,
                imageBuilder: (context, imageProvider) => Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey500Color,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.grey500Color,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 24, // You can adjust the size of the error icon
                    ),
                  );
                },
              ),

        SizedBox(height: 2.h),
        for(int i=0;i<screenController.promptsList.length;i++)...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  screenController.promptsList[i].question,
                  style: TextStyleConfig.textStyle(
                    fontFamily: FontFamilyText.sFProDisplaySemibold,
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
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.grey400Color,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    screenController.promptsList[i].answer,
                    textAlign: TextAlign.center,
                    style: TextStyleConfig.textStyle(
                      fontFamily: FontFamilyText.sFProDisplaySemibold,
                      textColor: AppColors.grey600Color,
                      //fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        // User Image Module
        SizedBox(height: 2.h),
        screenController.userImages.length < 3
            ? Container()
            : CachedNetworkImage(
                imageUrl: screenController.userImages[2].imageUrl,
                height: 50.h,
                imageBuilder: (context, imageProvider) => Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey500Color,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.grey500Color,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                },
              ),
        // User Prompts Module


        SizedBox(height: 2.h),
        screenController.userImages.length < 4
            ? Container()
            : ListView.builder(
                itemCount: screenController.userSubImagesList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return CachedNetworkImage(
                    imageUrl: screenController.userSubImagesList[i].imageUrl,
                    height: 50.h,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.grey500Color,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.grey500Color,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 24,
                        ),
                      );
                    },
                  ).commonSymmetricPadding(vertical: 10);
                },
              ),

        /*Container(
          height: 50.h,
          decoration:  BoxDecoration(
              color: AppColors.grey500Color,
              image:  DecorationImage(
                image: NetworkImage(
                  screenController.userImages[3].imageUrl,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
        ),*/

        /// User Location Module
        if (screenController.userCountry.value != '' ||
            screenController.userHomeTown.value != 'Add') ...[
          SizedBox(height: 2.h),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              "${screenController.userName}'s Location",
              style: TextStyleConfig.textStyle(
                fontFamily: FontFamilyText.sFProDisplayBold,
                textColor: AppColors.grey800Color,
                //fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          if (screenController.userCountry.value != '') ...[
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Image.asset(
                      AppImages.location2Image,
                      height: 2.h,
                    )),
                    TextSpan(
                      text: ' ${screenController.userCountry}',
                      style: TextStyleConfig.textStyle(
                        textColor: AppColors.grey800Color,
                        fontFamily: FontFamilyText.sFProDisplayRegular,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              // spacing: 2.0,
              children: List.generate(
                2,
                (int index) {
                  return (screenController.userCountry.value == '' &&
                              index == 0) ||
                          (screenController.userHomeTown.value == 'Add' &&
                              index == 1)
                      ? const SizedBox()
                      : Transform(
                          transform: Matrix4.identity()..scale(0.9),
                          child: ChoiceChip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: index == 1
                                  ? AssetImage(AppImages.locationHome)
                                  : AssetImage(AppImages.locationNow),
                            ),
                            label: Text(
                              index == 0
                                  ? 'Live in ${screenController.userCountry}'
                                  : "From ${screenController.userHomeTown}",
                              style: TextStyleConfig.textStyle(
                                fontFamily: FontFamilyText.sFProDisplaySemibold,
                                textColor: AppColors.grey600Color,
                                fontSize: 16,
                              ),
                            ),
                            selected: selected,
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
            ),
          ),
        ],
      ],
    ).commonSymmetricPadding(horizontal: 2, vertical: 15);
  }
}
