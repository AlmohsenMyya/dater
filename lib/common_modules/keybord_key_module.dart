import 'dart:developer';

import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/auth_screen_controllers/verification_code_screen_controller.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyBordKeyModule extends StatelessWidget {
  Function()? onTap;
  String text;
  final TextEditingController controller;
  final bool delete;

  KeyBordKeyModule({
    super.key,
    this.onTap,
    required this.text,
    required this.controller,
    this.delete = false,
  });

  final verifyCodeScreenController = Get.find<VerifyCodeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (delete) {
            if (controller.text.length > 0 && controller.text.length <= 4) {
              if (verifyCodeScreenController
                  .fourthDigitController.text.isNotEmpty) {
                verifyCodeScreenController.fourthDigitController.clear();
              } else if (verifyCodeScreenController
                  .thirdDigitController.text.isNotEmpty) {
                verifyCodeScreenController.thirdDigitController.clear();
              } else if (verifyCodeScreenController
                  .secondDigitController.text.isNotEmpty) {
                verifyCodeScreenController.secondDigitController.clear();
              } else if (verifyCodeScreenController
                  .firstDigitController.text.isNotEmpty) {
                verifyCodeScreenController.firstDigitController.clear();
              }
              controller.text =
                  controller.text.substring(0, controller.text.length - 1);
            }
          } else {
            if (controller.text.length < 4) {
              if (verifyCodeScreenController
                  .firstDigitController.text.isEmpty) {
                verifyCodeScreenController.firstDigitController.text +=
                    text.toString();
              } else if (verifyCodeScreenController
                  .secondDigitController.text.isEmpty) {
                verifyCodeScreenController.secondDigitController.text +=
                    text.toString();
              } else if (verifyCodeScreenController
                  .thirdDigitController.text.isEmpty) {
                verifyCodeScreenController.thirdDigitController.text +=
                    text.toString();
              } else if (verifyCodeScreenController
                  .fourthDigitController.text.isEmpty) {
                verifyCodeScreenController.fourthDigitController.text +=
                    text.toString();
              }
              controller.text += text.toString();
              log("controller.text : ${verifyCodeScreenController.controller.text}");
            }
          }
        },
        child: Center(
          child: Text(
            text,
            style: TextStyleConfig.textStyle(
              textColor: AppColors.grey500Color,
              fontSize: 24,
              fontFamily: FontFamilyText.sFProDisplayRegular,
            ),
          ),
        ),
      ),
    );
  }
}
