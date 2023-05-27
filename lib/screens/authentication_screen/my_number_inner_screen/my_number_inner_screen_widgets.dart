import 'dart:developer';

import 'package:dater/constants/font_family.dart';
import 'package:dater/controller/auth_screen_controllers/my_number_inner_screen_controller.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dater/utils/field_validator.dart';
import 'package:dater/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/colors.dart';
import '../../../constants/messages.dart';
import '../../../model/authentication_model/country_code_list_model/country_code_list_model.dart';

class TextFormFiledModule extends StatelessWidget {
  TextFormFiledModule({Key? key}) : super(key: key);

  final screenController = Get.find<MyNumberInnerScreenController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 25,
          child: GestureDetector(
            onTap: openBottomSheetModule,
            child: SizedBox(
              width: Get.size.width * 0.25,
              child: Container(
                decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.grey500Color)),
                ),
                child: Text(screenController.countryCodeController.text)
                    .commonSymmetricPadding(vertical: 8),
              ),
              /*child: TextFormField(
                 cursorColor: AppColors.darkOrangeColor,
                 controller: myNumberInnerScreenController.countryCodeController,
                 textInputAction: TextInputAction.next,
                 keyboardType: TextInputType.phone,
                 readOnly: true,
                 maxLength: 10,
                 // validator: (value) => FieldValidator().validateMobileNumber(value!),
                 decoration: InputDecoration(
                   focusedErrorBorder: const UnderlineInputBorder(
                     borderSide: BorderSide(color: AppColors.darkOrangeColor),
                   ),
                   enabledBorder: const UnderlineInputBorder(
                     borderSide: BorderSide(color: AppColors.grey500Color),
                   ),
                   focusedBorder: const UnderlineInputBorder(
                     borderSide: BorderSide(color: AppColors.darkOrangeColor),
                   ),
                   isDense: true,
                   counterText: '',
                   hintText: "",
                   hintStyle: TextStyle(
                     color: AppColors.grey500Color,
                     fontSize: 14,
                     fontFamily: FontFamilyText.sFProDisplayRegular,
                   ),
                 ),
               ),*/
/*              child: DropdownButton<CountryData>(
                  value: myNumberInnerScreenController.selectCountryCodeValue,
                  alignment: Alignment.centerLeft,
                  isExpanded: true,
                  items: myNumberInnerScreenController.countryCodeList
                      .map(
                        (item) => DropdownMenuItem<CountryData>(
                          // enabled: true,
                          value: item,
                          child: Text(
                            "${item.emoji} ${item.dialCode} ${item.code}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: FontFamilyText.sFProDisplayRegular,
                              fontSize: 14,
                              color: AppColors.grey800Color,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    myNumberInnerScreenController.isLoading(true);
                    myNumberInnerScreenController.selectCountryCodeValue = val!;
                    myNumberInnerScreenController.isLoading(false);
                  },
                ),*/
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 75,
          child: Form(
            key: screenController.formKey,
            child: TextFormField(
              cursorColor: AppColors.darkOrangeColor,
              controller: screenController.phoneNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: (value) =>
                  FieldValidator().validateMobileNumber(value!),
              decoration: InputDecoration(
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkOrangeColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey500Color),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkOrangeColor),
                ),
                isDense: true,
                counterText: '',
                hintText: AppMessages.phoneNumber,
                hintStyle: TextStyle(
                  color: AppColors.grey500Color,
                  fontSize: 14,
                  fontFamily: FontFamilyText.sFProDisplayRegular,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void openBottomSheetModule() {
    showModalBottomSheet(
        context: Get.context!,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: screenController.searchController,
                        cursorColor: AppColors.darkOrangeColor,
                        onChanged: (value) {
                          screenController.isLoading(true);
                          screenController.searchCountryCodeList =
                              screenController.countryCodeList
                                  .where((element) =>
                                      element.dialCode!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      element.name!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      element.code!
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                  .toList();
                          screenController.isLoading(false);
                        },
                        decoration: InputDecoration(
                          focusColor: AppColors.darkOrangeColor,
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.darkOrangeColor),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.grey500Color),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.darkOrangeColor),
                          ),
                          isDense: true,
                          hintText: AppMessages.countryAndRegion,
                          hintStyle: TextStyle(
                            color: AppColors.grey500Color,
                            fontSize: 14,
                            fontFamily: FontFamilyText.sFProDisplayRegular,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        screenController.searchCountryCodeList =
                            screenController.countryCodeList;
                        screenController.searchController.clear();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.darkOrangeColor,
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                        ),
                      ),
                    ),
                  ],
                ).commonSymmetricPadding(horizontal: 8, vertical: 5),
                Expanded(
                  child: Obx(
                    () => screenController.isLoading.value
                        ? Container()
                        : ListView.builder(
                            itemCount: screenController.searchCountryCodeList.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              // log("screenController.searchCountryCodeList.length, ${screenController.searchCountryCodeList.length}");
                              CountryData singleItem =
                                  screenController.searchCountryCodeList[i];
                              return ListTile(
                                dense: true,
                                onTap: () => screenController.onCountrySelectFunction(singleItem),
                                leading: Text(
                                    "${singleItem.emoji}",
                                  style: TextStyle(
                                    fontFamily:
                                    FontFamilyText.sFProDisplayRegular,
                                  ),
                                ),
                                title: Text(
                                  "${singleItem.dialCode} ${singleItem.code}",
                                  style: TextStyle(
                                    fontFamily:
                                    FontFamilyText.sFProDisplayRegular,
                                  ),
                                ),
                              );
                              /*return GestureDetector(
                                onTap: () {
                                  screenController.isLoading(true);
                                  screenController.countryCodeController.text =
                                      "${singleItem.emoji} ${singleItem.dialCode} ${singleItem.code}";
                                  screenController.selectCountryCodeValue = singleItem;
                                  screenController.isLoading(false);
                                  Get.back();
                                  screenController.searchCountryCodeList =
                                      screenController.countryCodeList;
                                  screenController.searchController.clear();
                                },
                                child: Text(
                                  "${singleItem.emoji} ${singleItem.dialCode} ${singleItem.code}",
                                  style: TextStyle(
                                    fontFamily:
                                        FontFamilyText.sFProDisplayRegular,
                                  ),
                                ).commonSymmetricPadding(horizontal: 8, vertical: 10),
                              );*/
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class TextCustomModule extends StatelessWidget {
  const TextCustomModule({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AppMessages.myNumberScreenInformationText,
        style: TextStyleConfig.textStyle(
          fontFamily: "SFProDisplayRegular",
          textColor: AppColors.grey600Color,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}
