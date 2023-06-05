import 'package:dater/common_modules/custom_appbar.dart';
import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_screen_controllers/add_user_photo_screen_controller.dart';
import 'add_user_photo_screen_widgets.dart';

class AddUserPhotoScreen extends StatelessWidget {
  AddUserPhotoScreen({Key? key}) : super(key: key);
  final addUserPhotoScreenController = Get.put(AddUserPhotoScreenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 1.0],
          colors: [
            AppColors.darkOrangeColor,
            AppColors.yellowColor,
          ],
        ),
      ),
      child: Obx(
        () => addUserPhotoScreenController.isLoading.value
            ? const CustomLoader()
            : Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: commonAppBarModule(
                    text: "Add your first photo",
                    iconColor: AppColors.blackColor,
                    backGroundColor: Colors.transparent),
                body: Column(
                  children: [
                    const Text(
                      'At least you need three photos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "SFProDisplayRegular", fontSize: 15),
                    ).commonOnlyPadding(top: 5, bottom: 6),
                    const Text(
                      'For a better experience, \n please upload photo with a file size of 2MB or less.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "SFProDisplayRegular", fontSize: 14),
                    ).commonSymmetricPadding(vertical: 5, horizontal: 20),
                    const SizedBox(height: 25),
                    UserImageSelectModule(),
                    const Text(
                      "don't worry you can add more photos later on !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "SFProDisplayRegular", fontSize: 15),
                    ).commonSymmetricPadding(vertical: 8, horizontal: 20),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ButtonCustom(
                        text: "Photo hints",
                        onPressed: () {},
                        size: const Size(50, 0),
                        fontWeight: FontWeight.bold,
                        textsize: 15,
                        textFontFamily: "SFProDisplayHeavy",
                      ).commonSymmetricPadding(horizontal: 20),
                    ),
                    const SizedBox(height: 20),
                    const PointHintModule(),
                    Expanded(child: Container()),
                  ],
                ),
                bottomNavigationBar: ButtonCustom(
                  text: "Done",
                  textFontFamily: FontFamilyText.sFProDisplayBold,
                  textsize: 15,
                  onPressed: () async =>
                      await addUserPhotoScreenController.doneButtonFunction(),
                ).commonSymmetricPadding(horizontal: 20, vertical: 10),
              ),
      ),
    );
  }
}
