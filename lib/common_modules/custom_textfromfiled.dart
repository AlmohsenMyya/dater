import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextFormFiledCustom extends StatelessWidget {
  TextEditingController fieldController;
  String hintText;
  TextInputType keyboardType;
  FormFieldValidator? validate;
  int? maxLength;
  Widget? suffixIcon;
  Color textColor;
  Color fillColor;

  Widget? prefixIcon;
  bool? obscureText;
  String textFontFamily;

  TextFormFiledCustom({
    Key? key,
    required this.fieldController,
    required this.hintText,
    required this.keyboardType,
    this.textColor = AppColors.grey400Color,
    this.fillColor = AppColors.gray100Color,
    this.validate,
    this.maxLength,
    this.suffixIcon,
    // this.suffixIcon,

    this.prefixIcon,
    this.textFontFamily = "SFProDisplayRegular",
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.darkOrangeColor,
      controller: fieldController,
      validator: validate,
      obscureText: obscureText ?? false,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        //counterText: '',
        hintStyle: TextStyle(
          color: textColor,
          fontFamily: textFontFamily,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      ),
    );
  }

  InputBorder inputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}

class noShadowTextFormFiledCustom extends StatelessWidget {
  TextEditingController fieldController;
  String hintText;
  TextInputType keyboardType;
  FormFieldValidator? validate;
  int? maxLength;
  Widget? suffixIcon;
  Color textColor;
  Color fillColor;

  Widget? prefixIcon;
  bool? obscureText;
  String textFontFamily;
  noShadowTextFormFiledCustom({
    Key? key,
    required this.fieldController,
    required this.hintText,
    required this.keyboardType,
    this.textColor = AppColors.grey400Color,
    this.fillColor = AppColors.gray100Color,
    this.validate,
    this.maxLength,
    this.suffixIcon,
    // this.suffixIcon,

    this.prefixIcon,
    this.textFontFamily = "SFProDisplayRegular",
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.darkOrangeColor,
      controller: fieldController,
      validator: validate,
      obscureText: obscureText ?? false,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        //counterText: '',
        hintStyle: TextStyle(
          color: textColor,
          fontFamily: textFontFamily,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      ),
    );
  }

  InputBorder inputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: AppColors.grey400Color),
    );
  }
}
