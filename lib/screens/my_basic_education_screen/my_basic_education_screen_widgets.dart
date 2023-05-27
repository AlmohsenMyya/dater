import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/my_basic_education_screen_controller.dart';
import '../../utils/field_validator.dart';
import '../../utils/style.dart';

class InstitutionFieldModule extends StatelessWidget {
  InstitutionFieldModule({Key? key}) : super(key: key);
  final screenController = Get.find<MyBasicEducationScreenController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.lightOrangeColor,
      maxLines: 1,
      controller: screenController.institutionFieldController,
      textAlign: TextAlign.center,
      validator: (value) => FieldValidator().validateWorkTitle(value!),
      decoration: InputDecoration(
        hintText: "Institution",
        hintStyle: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.grey600Color,
          fontSize: 15.sp,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
      ),
      style: TextStyleConfig.textStyle(
        fontFamily: FontFamilyText.sFProDisplayRegular,
        fontSize: 15.sp,
        textColor: AppColors.grey600Color,
      ),
    );
  }
}


class GraduationYearFieldModule extends StatelessWidget {
  GraduationYearFieldModule({Key? key}) : super(key: key);
  final screenController = Get.find<MyBasicEducationScreenController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.lightOrangeColor,
      maxLines: 1,
      controller: screenController.graduationYearFieldController,
      textAlign: TextAlign.center,
      validator: (value) => FieldValidator().validateWorkCompany(value!),
      decoration: InputDecoration(
        hintText: "Graduation year",
        hintStyle: TextStyleConfig.textStyle(
          fontFamily: FontFamilyText.sFProDisplayRegular,
          textColor: AppColors.grey600Color,
          fontSize: 15.sp,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
        ),
      ),
      style: TextStyleConfig.textStyle(
        fontFamily: FontFamilyText.sFProDisplayRegular,
        fontSize: 15.sp,
        textColor: AppColors.grey600Color,
      ),
    );
  }
}