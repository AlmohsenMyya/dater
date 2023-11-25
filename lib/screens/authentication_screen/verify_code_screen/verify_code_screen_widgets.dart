import 'package:dater/common_modules/keybord_key_module.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/controller/auth_screen_controllers/verification_code_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VerificationCodeFieldModule extends StatelessWidget {
  VerificationCodeFieldModule({super.key});

  final verifyCodeScreenController = Get.find<VerifyCodeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: verifyCodeScreenController.formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 15.w,
            height: 15.w,
            child: TextFormField(
              cursorColor: AppColors.darkOrangeColor,
              controller: verifyCodeScreenController.firstDigitController,
              readOnly: true,
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    color: AppColors.grey700Color,
                    fontSize: 15.sp,
                  ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: InputFieldStyles().inputBorder(),
                focusedBorder: InputFieldStyles().inputBorder(),
                errorBorder: InputFieldStyles().errorBorder(),
                focusedErrorBorder: InputFieldStyles().errorBorder(),
                hintText: '0',
                hintStyle: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  textColor: AppColors.grey500Color,
                  fontSize: 15.sp,
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
            height: 15.w,
            child: TextFormField(
              cursorColor: AppColors.darkOrangeColor,
              controller: verifyCodeScreenController.secondDigitController,
              readOnly: true,
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    color: AppColors.grey700Color,
                    fontSize: 15.sp,
                  ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: InputFieldStyles().inputBorder(),
                focusedBorder: InputFieldStyles().inputBorder(),
                errorBorder: InputFieldStyles().errorBorder(),
                focusedErrorBorder: InputFieldStyles().errorBorder(),
                hintText: '0',
                hintStyle: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  textColor: AppColors.grey500Color,
                  fontSize: 15.sp,
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
            height: 15.w,
            child: TextFormField(
              cursorColor: AppColors.darkOrangeColor,
              controller: verifyCodeScreenController.thirdDigitController,
              readOnly: true,
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                } else if (value.length == 0) {
                  FocusScope.of(context).previousFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    color: AppColors.grey700Color,
                    fontSize: 15.sp,
                  ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: InputFieldStyles().inputBorder(),
                focusedBorder: InputFieldStyles().inputBorder(),
                errorBorder: InputFieldStyles().errorBorder(),
                focusedErrorBorder: InputFieldStyles().errorBorder(),
                hintText: '0',
                hintStyle: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  textColor: AppColors.grey500Color,
                  fontSize: 15.sp,
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          SizedBox(
            width: 15.w,
            height: 15.w,
            child: TextFormField(
              cursorColor: AppColors.darkOrangeColor,
              controller: verifyCodeScreenController.fourthDigitController,
              readOnly: true,
              onChanged: (value) {
                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamilyText.sFProDisplayRegular,
                    color: AppColors.grey700Color,
                    fontSize: 15.sp,
                  ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: InputFieldStyles().inputBorder(),
                focusedBorder: InputFieldStyles().inputBorder(),
                errorBorder: InputFieldStyles().errorBorder(),
                focusedErrorBorder: InputFieldStyles().errorBorder(),
                hintText: '0',
                hintStyle: TextStyleConfig.textStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                  textColor: AppColors.grey500Color,
                  fontSize: 15.sp,
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ],
      ).commonSymmetricPadding(horizontal: 10.w),
    );
  }
}

class ResendButtonModule extends StatelessWidget {
  ResendButtonModule({super.key});

  final verifyCodeScreenController = Get.find<VerifyCodeScreenController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await verifyCodeScreenController.resendCodeFunction();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightOrangeColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          AppMessages.resend,
          style: TextStyleConfig.textStyle(
            fontFamily: "SFProDisplayBold",
            textColor: AppColors.lightOrangeColor,
          ),
        ).commonSymmetricPadding(horizontal: 12, vertical: 3),
      ),
    );
  }
}

class KeyBoardeCustomModule extends StatelessWidget {
  KeyBoardeCustomModule({super.key});

  final verifyCodeScreenController = Get.find<VerifyCodeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: AppColors.grey300Color,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "1",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "2",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "3",
                // onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "4",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "5",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "6",
                // onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "7",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "8",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                text: "9",
                controller: verifyCodeScreenController.controller,
                // onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              KeyBordKeyModule(
                text: "*",
                // onTap: () {},
                controller: verifyCodeScreenController.controller,
              ),
              KeyBordKeyModule(
                controller: verifyCodeScreenController.controller,
                text: "0",
                // onTap: () {},
              ),
              KeyBordKeyModule(
                delete: true,
                controller: verifyCodeScreenController.controller,
                text: "Del",
                // onTap: () {},
              ),
            ],
          )
        ],
      ).commonSymmetricPadding(vertical: 25),
    ).commonSymmetricPadding(horizontal: 55, vertical: 20);
  }
}
