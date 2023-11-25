import 'dart:developer';

import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/auth_screen_controllers/dob_select_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DobSelectModule extends StatelessWidget {
  DobSelectModule({Key? key}) : super(key: key);
  final screenController = Get.find<DobSelectScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
        border: Border.all(
          color: AppColors.grey300Color,
          width: 2,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          _showDatePicker(context);
        },
        child: Column(
          children: [
            Text(
              "My birthday is",
              style: TextStyle(
                  fontFamily: FontFamilyText.sFProDisplaySemibold,
                  fontSize: 18),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Text(
                screenController.dobString.value,
                style: TextStyle(
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  fontSize: 14,
                  color: AppColors.grey600Color,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: AppColors.grey600Color,
              height: 1,
              endIndent: 10,
              indent: 10,
            ),
            const SizedBox(height: 10),
            Text(
              "Your age will be public",
              style: TextStyle(
                fontSize: 13,
                color: AppColors.grey500Color,
                fontFamily: FontFamilyText.sFProDisplayRegular,
              ),
            ),
          ],
        ).commonSymmetricPadding(horizontal: 10, vertical: 20),
      ),
    ).paddingSymmetric(horizontal: 10);
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Material(
              child: Container(
                // height: 300,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppColors.darkOrangeColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            screenController.setDobInStringFunction();
                          },
                          icon: const Icon(
                            Icons.check_rounded,
                            color: AppColors.darkOrangeColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 300,
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (val) {
                            log('val : $val');
                            // _chosenDateTime = val;
                            screenController.tempDobString = val;
                          }),
                    ),

                    // Close the modal
                    // CupertinoButton(
                    //   child: const Text('OK'),
                    //   onPressed: () => Navigator.of(ctx).pop(),
                    // )
                  ],
                ),
              ),
            ));
  }
}

class AgeNotesModule extends StatelessWidget {
  const AgeNotesModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Container(),
        ),
        Expanded(
          flex: 85,
          child: Column(
            children: [
              _singleItemModule(
                number: '1- ',
                text:
                    'We only show your age on your profile not your birthday !',
              ),
              _singleItemModule(
                number: '2- ',
                text: 'Make sure your +18',
              ),
              _singleItemModule(
                number: '3- ',
                text:
                    'Make sure this will be your right age, you cant change it later !',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _singleItemModule({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            fontFamily: FontFamilyText.sFProDisplayRegular,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontFamilyText.sFProDisplayRegular,
              fontSize: 18,
            ),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 6);
  }
}
