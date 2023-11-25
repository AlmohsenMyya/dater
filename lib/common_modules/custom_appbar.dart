import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_images.dart';
import '../constants/colors.dart';

PreferredSizeWidget commonAppBarModule(
    {required String text,
      bool isLeadingShow = true,
    Color iconColor = AppColors.blackColor,
    String textFontFamily = "SFProDisplayRegular",
    Color textColor = AppColors.blackColor,
    Color backGroundColor = AppColors.whiteColor2}) {
  return AppBar(
    backgroundColor: backGroundColor,
    leading: isLeadingShow == true
      ? Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.back();
          },
          icon: Icon(
            Icons.west_outlined,
            color: iconColor,
          ),
        );
      },
    ) : null,
    centerTitle: true,
    elevation: 0,
    title: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontFamily: textFontFamily,
        fontSize: 20.sp,
      ),
    ),
  );
}


PreferredSizeWidget appBarModule(
    {required String text,
      required String userImage,
      Color iconColor = AppColors.lightOrangeColor,
      String textFontFamily = "SFProDisplayRegular",
      Color textColor = AppColors.grey800Color,
      Color backGroundColor = AppColors.whiteColor2}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: backGroundColor,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.back();
          },
          icon: Icon(
            Icons.west_outlined,
            color: iconColor,
          ),
        );
      },
    ),
    centerTitle: true,
    elevation: 0,
    title: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontFamily: textFontFamily,
        fontSize: 20.sp,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.network(
              userImage,
              fit: BoxFit.cover,
              errorBuilder: (context, st, obj) {
                return Image.asset(AppImages.chatimage);
              },
            ),
          ),
        ),
      ),
    ],
  );
}