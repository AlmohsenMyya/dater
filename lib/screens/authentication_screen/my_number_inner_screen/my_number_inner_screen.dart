import 'package:dater/common_modules/custom_button.dart';
import 'package:dater/common_modules/custom_loader.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/controller/auth_screen_controllers/my_number_inner_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common_modules/custom_appbar.dart';
import '../../../constants/font_family.dart';
import '../../../constants/messages.dart';
import '../../../utils/field_validator.dart';
import '../../../utils/style.dart';
import 'my_number_inner_screen_widgets.dart';

class MyNumberInnerScreen extends StatelessWidget {
  MyNumberInnerScreen({Key? key}) : super(key: key);
  final myNumberInnerScreenController =
      Get.put(MyNumberInnerScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: commonAppBarModule(text: AppMessages.myNumberIs),
      body: SingleChildScrollView(
        child: Obx(
          () => myNumberInnerScreenController.isLoading.value
              ? const CustomLoader()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    TextFormFiledModule(),
                    SizedBox(height: 4.h),
                    const TextCustomModule(),
                    SizedBox(height: 7.h),
                    ButtonCustom(
                      size: const Size(double.infinity, 50),
                      backgroundColor: AppColors.lightOrangeColor,
                      shadowColor: Colors.blueGrey,
                      text: AppMessages.continueButton,
                      textColor: AppColors.whiteColor2,
                      fontWeight: FontWeight.bold,
                      textsize: 14.sp,
                      onPressed: () async {
                        await myNumberInnerScreenController
                            .onContinueButtonClickFunction();
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      children: [
                        Text(
                          "Do you have a referral number from a friend ?",
                          style: TextStyleConfig.textStyle(
                            fontFamily: FontFamilyText.sFProDisplayBold,
                            textColor: AppColors.blackColor,
                            fontSize: 16.sp,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          cursorColor: AppColors.darkOrangeColor,
                          controller:
                              myNumberInnerScreenController.referralNumber,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) =>
                              FieldValidator().validateMobileNumber(value!),
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: AppColors.darkOrangeColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: AppColors.grey500Color),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: AppColors.darkOrangeColor),
                            ),
                            isDense: true,
                            counterText: '',
                            hintText: "Friend's referral code",
                            hintStyle: TextStyle(
                              color: AppColors.grey500Color,
                              fontSize: 14,
                              fontFamily: FontFamilyText.sFProDisplayRegular,
                            ),
                          ),
                        ).commonSymmetricPadding(horizontal: 45),
                      ],
                    ).commonSymmetricPadding(horizontal: 25),
                  ],
                ).commonSymmetricPadding(horizontal: 15),
        ),
      ),
    );
  }
}
