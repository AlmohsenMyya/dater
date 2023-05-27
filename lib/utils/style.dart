import 'package:dater/constants/colors.dart';
import 'package:flutter/material.dart';

class TextStyleConfig {
  static TextStyle textStyle({
    Color textColor = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 15.0,
    String fontFamily = "SFProDisplayRegular",
  }) {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle drawerTextStyle({
    Color textColor = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 18.0,
  }) {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}

class InputFieldStyles {
  InputBorder inputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    
    );
  }


  InputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red),
      // borderSide: const BorderSide(width: 1.0),
    );
  }
}
