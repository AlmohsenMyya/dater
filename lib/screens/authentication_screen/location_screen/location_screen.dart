import 'package:dater/common_function/hide_keyboard.dart';
import 'package:dater/constants/messages.dart';
import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_appbar.dart';
import '../../../common_modules/custom_button.dart';
import '../../../common_modules/custom_loader.dart';
import '../../../constants/colors.dart';
import '../../../constants/font_family.dart';
import '../../../controller/auth_screen_controllers/location_screen_controller.dart';
import '../../../utils/field_validator.dart';
import '../../../utils/style.dart';
import '../username_screen/username_screen.dart';
import 'location_screen_widgets.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);
  final locationScreenController = Get.put(LocationScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyBoard(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor2,
        appBar: commonAppBarModule(text: AppMessages.location),

        /*body: Obx(
              () => locationScreenController.isLoading.value
              ? const CustomLoader()
              : SingleChildScrollView(
            child: Form(
              key: locationScreenController.formKey,
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.05),
                  LocationFieldModule()
                      .commonSymmetricPadding(horizontal: 20, vertical: 10),
                ],
              ),
            ),
          ),
        ),*/

        body: SafeArea(
          child: Obx(
            () => locationScreenController.isLoading.value
                ? const CustomLoader()
                : Column(
                    children: [
                      SearchTextFiledModule()
                          .commonSymmetricPadding(horizontal: 20),
                      SizedBox(height: 3.h),
                      CountryListViewModule(),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: ButtonCustom(
                backgroundColor: AppColors.darkOrangeColor,
                text: AppMessages.confirm,
                fontWeight: FontWeight.bold,
                textsize: 14.sp,
                textColor: AppColors.gray50Color,
                onPressed: () async => await locationScreenController.confirmButtonFunction(),
                shadowColor: AppColors.grey900Color)
            .commonSymmetricPadding(horizontal: 25, vertical: 30),
      ),
    );
  }
}

/// Widget's of this screen
// class LocationFieldModule extends StatelessWidget {
//   LocationFieldModule({Key? key}) : super(key: key);
//   final screenController = Get.find<LocationScreenController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorColor: AppColors.lightOrangeColor,
//       maxLines: 1,
//       controller: screenController.locationFieldController,
//       textAlign: TextAlign.center,
//       validator: (value) => FieldValidator().validateHomeTown(value!),
//       decoration: InputDecoration(
//         hintText: "Enter Location",
//         hintStyle: TextStyleConfig.textStyle(
//           fontFamily: FontFamilyText.sFProDisplayRegular,
//           textColor: AppColors.grey600Color,
//           fontSize: 15.sp,
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
//         ),
//         errorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
//         ),
//         focusedErrorBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(color: AppColors.grey300Color, width: 3),
//         ),
//       ),
//       style: TextStyleConfig.textStyle(
//         fontFamily: FontFamilyText.sFProDisplayRegular,
//         fontSize: 15.sp,
//         textColor: AppColors.grey600Color,
//       ),
//     );
//   }
// }
