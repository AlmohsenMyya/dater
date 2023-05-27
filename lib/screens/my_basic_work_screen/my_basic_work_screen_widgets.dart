import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../controller/my_basic_work_screen_controller.dart';
import '../../utils/field_validator.dart';
import '../../utils/style.dart';

class TitleFieldModule extends StatelessWidget {
  TitleFieldModule({Key? key}) : super(key: key);
  final screenController = Get.find<MyBasicWorkScreenController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.lightOrangeColor,
      maxLines: 1,
      controller: screenController.titleFieldController,
      textAlign: TextAlign.center,
      validator: (value) => FieldValidator().validateWorkTitle(value!),
      decoration: InputDecoration(
        hintText: "Title",
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

class CompanyFieldModule extends StatelessWidget {
  CompanyFieldModule({Key? key}) : super(key: key);
  final screenController = Get.find<MyBasicWorkScreenController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.lightOrangeColor,
      maxLines: 1,
      controller: screenController.companyFieldController,
      textAlign: TextAlign.center,
      validator: (value) => FieldValidator().validateWorkCompany(value!),
      decoration: InputDecoration(
        hintText: "Company ( or just industry )",
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


