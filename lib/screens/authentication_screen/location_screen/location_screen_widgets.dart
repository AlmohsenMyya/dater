import 'package:dater/constants/app_images.dart';
import 'package:dater/constants/colors.dart';
import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/auth_screen_controllers/location_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common_modules/custom_textfromfiled.dart';
import '../../../constants/messages.dart';

class SearchTextFiledModule extends StatelessWidget {
  SearchTextFiledModule({Key? key}) : super(key: key);
  final screenController = Get.find<LocationScreenController>();


  @override
  Widget build(BuildContext context) {
    final locationScreenController = Get.find<LocationScreenController>();
    //TextEditingController searchTextFieldController = TextEditingController();
    return Row(
      children: [
        Form(
          key: locationScreenController.formKey,
          child: Expanded(
            child: SizedBox(
              height: 5.7.h,
              child: Material(
                elevation: 9.0,
                shadowColor: AppColors.gray100Color,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  cursorColor: AppColors.darkOrangeColor,
                  controller: screenController.searchTextFieldController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if(value.isNotEmpty) {
                      screenController.searchCountryFunction(value);
                    } else if(value.isEmpty) {
                      screenController.searchCountryList = screenController.countryList;
                      screenController.loadUI();
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: inputBorder(),
                    focusedBorder: inputBorder(),
                    errorBorder: inputBorder(),
                    focusedErrorBorder: inputBorder(),
                    fillColor: AppColors.gray100Color,
                    filled: true,
                    hintText: AppMessages.search,
                    errorMaxLines: 2,
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: Image.asset(AppImages.findImage),
                    hintStyle: TextStyle(
                      color: AppColors.grey400Color,
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                  ),
                ),
                /*child: TextFormFiledCustom(
                  fieldController:
                      locationScreenController.searchTextFieldController,
                  hintText: AppMessages.search,
                  keyboardType: TextInputType.text,
                  suffixIcon: Image.asset(AppImages.findImage),
                  prefixIcon: const Icon(Icons.search, size: 20),

                ),*/
              ),
            ),
          ),
        ),
      ],
    );
  }


  InputBorder inputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }


}

class CountryListViewModule extends StatelessWidget {
  CountryListViewModule({Key? key}) : super(key: key);
  final screenController = Get.find<LocationScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 10.h,
        //padding: EdgeInsets.only(left: 3.w),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          // shrinkWrap: true,
          itemCount: screenController.searchCountryList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                String countryId = screenController.searchCountryList[index].id!;
                screenController.countryValueSelectFromListFunction(countryId);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: screenController.searchCountryList[index].isSelected == true ? AppColors.darkOrangeColor : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 4.h,
                      child: Image.asset(
                        //fit: BoxFit.fitHeight,
                        //alignment: Alignment.bottomRight,
                        // cacheHeight: 45,
                        AppImages.location2Image,
                      ),
                    ).commonOnlyPadding(left: 3.w),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  screenController.searchCountryList[index].name!,
                                  maxLines: 2,
                                  style: TextStyleConfig.textStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      //textColor: AppColors.grey500Color,
                                      fontFamily: "SFProDisplayRegular"),
                                ),
                              ),
                            ],
                          ).commonOnlyPadding(left: 2.5.w),
                          /*Row(
                            children: [
                              Text(
                                'New york',
                                style: TextStyleConfig.textStyle(
                                    textColor: AppColors.grey500Color,
                                    fontFamily: "SFProDisplayRegular"),
                              ),
                            ],
                          ),*/
                        ],
                      ).commonSymmetricPadding(vertical: 5),
                    ),
                  ],
                ).commonSymmetricPadding(horizontal: 12),
              ),
            ).commonSymmetricPadding(horizontal: 5);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
