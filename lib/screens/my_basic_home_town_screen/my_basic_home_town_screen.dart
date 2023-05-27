import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_function/hide_keyboard.dart';
import '../../common_modules/custom_appbar.dart';
import '../../common_modules/custom_button.dart';
import '../../common_modules/custom_loader.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/my_basic_home_town_screen_controller.dart';
import '../../utils/field_validator.dart';
import '../../utils/style.dart';

class MyBasicHomeTownScreen extends StatelessWidget {
  MyBasicHomeTownScreen({Key? key}) : super(key: key);
  final myBasicHomeTownScreenController = Get.put(MyBasicHomeTownScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> hideKeyBoard(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor2,
        appBar: commonAppBarModule(text: AppMessages.homeTownHeaderText),

        body: Obx(
            () => myBasicHomeTownScreenController.isLoading.value
                ? const CustomLoader()
                : SingleChildScrollView(
              child: Form(
                key: myBasicHomeTownScreenController.formKey,
                child: Column(
                  children: [
                    HomeTownFieldModule()
                        .commonSymmetricPadding(horizontal: 20, vertical: 10),
                  ],
                ),
              ),
            ),
        ),

        bottomNavigationBar: ButtonCustom(
          text: "Done",
          textFontFamily: FontFamilyText.sFProDisplayBold,
          textsize: 15,
          backgroundColor: AppColors.darkOrangeColor,
          textColor: AppColors.whiteColor2,
          onPressed: () async =>
          await myBasicHomeTownScreenController.doneButtonClick(),
        ).commonSymmetricPadding(horizontal: 20, vertical: 10),

      ),
    );
  }
}



/// Widget's of this screen
class HomeTownFieldModule extends StatelessWidget {
  HomeTownFieldModule({Key? key}) : super(key: key);
  final screenController = Get.find<MyBasicHomeTownScreenController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.lightOrangeColor,
      maxLines: 1,
      controller: screenController.homeTownFieldController,
      textAlign: TextAlign.center,
      validator: (value) => FieldValidator().validateHomeTown(value!),
      decoration: InputDecoration(
        hintText: "Home Town",
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