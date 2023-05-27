import 'package:dater/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/font_family.dart';
import '../../constants/messages.dart';
import '../../controller/personal_info_screen_controller.dart';
import '../../model/authentication_model/country_code_list_model/country_code_list_model.dart';
import '../../utils/field_validator.dart';
import '../../utils/style.dart';

class TextFiled1Module extends StatelessWidget {
  TextFiled1Module({Key? key}) : super(key: key);
  final personalInfoScreenController = Get.find<PersonalInfoScreenController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: personalInfoScreenController.formKey,
      child: Column(
        children: [
          // Old phone number
          Row(
            children: [
              Expanded(
                flex: 25,
                child: GestureDetector(
                  onTap: () => openBottomSheetModule(countrySelectedType: CountrySelectedType.oldCountry),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: AppColors.grey500Color)),
                    ),
                    child: Text(personalInfoScreenController.oldCountryCode.value)
                        .commonSymmetricPadding(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 75,
                child: TextFormField(
                  cursorColor: AppColors.darkOrangeColor,
                  controller: personalInfoScreenController.phoneNumberController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) => FieldValidator().validateMobileNumber(value!),
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
            ],
          ),

          // New phone number
          Row(
            children: [
              Expanded(
                  flex: 25,
                  child: GestureDetector(
                    onTap: () => openBottomSheetModule(countrySelectedType: CountrySelectedType.newCountry),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: AppColors.grey500Color)),
                      ),
                      child: Text(personalInfoScreenController.newCountryCode.value)
                          .commonSymmetricPadding(vertical: 10),
                    ),
                  )),
              const SizedBox(width: 20),
              Expanded(
                flex: 75,
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.darkOrangeColor,
                      controller:
                          personalInfoScreenController.newNumberTextFieldController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: (value) =>
                          FieldValidator().validatePhoneNumber(value!),
                      decoration: InputDecoration(
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
                        counterText: '',
                        hintText: AppMessages.newPhoneNumber,
                        hintStyle: TextStyle(
                          color: AppColors.grey500Color,
                          fontSize: 14,
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }

  void openBottomSheetModule({required CountrySelectedType countrySelectedType}) {
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
                        controller: personalInfoScreenController.searchController,
                        cursorColor: AppColors.darkOrangeColor,
                        onChanged: (value) {
                          personalInfoScreenController.isLoading(true);
                          personalInfoScreenController.searchCountryCodeList =
                              personalInfoScreenController.countryCodeList
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
                          personalInfoScreenController.isLoading(false);
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
                        personalInfoScreenController.searchCountryCodeList =
                            personalInfoScreenController.countryCodeList;
                        personalInfoScreenController.searchController.clear();
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
                        () => personalInfoScreenController.isLoading.value
                        ? Container()
                        : ListView.builder(
                      itemCount: personalInfoScreenController.searchCountryCodeList.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        CountryData singleItem =
                        personalInfoScreenController.searchCountryCodeList[i];
                        return ListTile(
                          dense: true,
                          onTap: () => personalInfoScreenController.onCountrySelectFunction(singleItem, countrySelectedType),
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
                                  personalInfoScreenController.isLoading(true);
                                  personalInfoScreenController.countryCodeController.text =
                                      "${singleItem.emoji} ${singleItem.dialCode} ${singleItem.code}";
                                  personalInfoScreenController.selectCountryCodeValue = singleItem;
                                  personalInfoScreenController.isLoading(false);
                                  Get.back();
                                  personalInfoScreenController.searchCountryCodeList =
                                      personalInfoScreenController.countryCodeList;
                                  personalInfoScreenController.searchController.clear();
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