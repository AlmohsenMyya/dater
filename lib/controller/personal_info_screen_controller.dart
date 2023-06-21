import 'dart:convert';
import 'dart:developer';

import 'package:dater/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/api_url.dart';
import '../constants/enums.dart';
import '../model/authentication_model/country_code_list_model/country_code_list.dart';
import '../model/authentication_model/country_code_list_model/country_code_list_model.dart';
import '../model/saved_data_model/saved_data_model.dart';
import '../screens/authentication_screen/verify_code_screen/verify_code_screen.dart';
import '../utils/preferences/user_preference.dart';
import 'auth_screen_controllers/verification_code_screen_controller.dart';

class PersonalInfoScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldNumberTextFieldController = TextEditingController();
  RxString oldCountryCode = "".obs;

  TextEditingController newNumberTextFieldController = TextEditingController();
  RxString newCountryCode = "".obs;

  String prefsCountryDialCode = "";

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<CountryData> searchCountryCodeList = [];
  List<CountryData> countryCodeList = [];
  CountryData selectCountryCodeValue = CountryData();
  CountryData newCountryCodeValue = CountryData();

  String newMobileNumber = "";

  UserPreference userPreference = UserPreference();

  // When select on country
  Future<void> getCountryCodesFunction() async {
    isLoading(true);
    // String url = ApiUrl.getCountryCodeApi;
    // log('Country Code List Api Url :$url');

    try {
      CountryListModel countryListModel =
          CountryListModel.fromJson(json.decode(CountryModel.countryList));
      countryCodeList.addAll(countryListModel.countryList);
      searchCountryCodeList = countryCodeList;
      log('searchCountryCodeList Length : ${searchCountryCodeList.length}');
      String temp = await userPreference.getStringFromPrefs(
          key: UserPreference.userCountryCodeKey);
      selectCountryCodeValue = searchCountryCodeList
              .firstWhereOrNull((element) => element.dialCode == temp) ??
          countryCodeList[0];
      oldCountryCode.value = "${selectCountryCodeValue.emoji} "
          "${selectCountryCodeValue.dialCode} ${selectCountryCodeValue.code}";
      newCountryCode.value = "${selectCountryCodeValue.emoji} "
          "${selectCountryCodeValue.dialCode} ${selectCountryCodeValue.code}";

      for (var element in searchCountryCodeList) {
        if (prefsCountryDialCode == element.code) {
          selectCountryCodeValue = CountryData(
              name: element.name,
              code: element.code,
              dialCode: element.dialCode,
              emoji: element.emoji);
          newCountryCodeValue = CountryData(
              name: element.name,
              code: element.code,
              dialCode: element.dialCode,
              emoji: element.emoji);
          oldCountryCode.value =
              "${element.emoji} ${element.dialCode} ${element.code}";
          newCountryCode.value =
              " ${element.emoji} ${element.dialCode} ${element.code}";
        }
      }
    } catch (e) {
      log('getCountryCodesFunction Error :$e');
      rethrow;
    }

    isLoading(false);
  }

  // Continue Button Function
  Future<void> nextButtonClickFunction() async {
    if (formKey.currentState!.validate()) {
      log('Mobile Number :${phoneNumberController.text.trim()}');

      newMobileNumber =
          "${selectCountryCodeValue.dialCode}${newNumberTextFieldController.text.trim()}";
      log('newMobileNumber : $newMobileNumber');

      await changeMobileNumberFunction(newMobileNumber);
    }
  }

  Future<void> changeMobileNumberFunction(String mobileNumber) async {
    isLoading(true);
    String url = ApiUrl.changePhoneNumberApi;
    log('changeMobileNumberFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['phone'] = mobileNumber;

      log('Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value1) async {
        printAll(name: 'response change phone','value : $value1');
        SavedDataModel savedDataModel =
            SavedDataModel.fromJson(json.decode(value1));
        successStatus.value = savedDataModel.statusCode;

        if (successStatus.value == 200) {
          Fluttertoast.showToast(msg: savedDataModel.msg);
          Get.delete<VerifyCodeScreenController>();
          Get.to(
            () => VerifyCodeScreen(),
            arguments: [
              selectCountryCodeValue.dialCode,
              newNumberTextFieldController.text.trim(),
              AuthAs.login,
              ComingFrom.changeNumberScreen,
            ],
          );
        } else {
          log('changeMobileNumberFunction Else');
        }
      });
    } catch (e) {
      log('changeMobileNumberFunction Error :$e');
      rethrow;
    }
  }

  onCountrySelectFunction(
      CountryData singleItem, CountrySelectedType countrySelectedType) {
    isLoading(true);
    String countryCode =
        "${singleItem.emoji} ${singleItem.dialCode} ${singleItem.code}";
    if (countrySelectedType == CountrySelectedType.oldCountry) {
      oldCountryCode.value = countryCode;
    } else {
      newCountryCode.value = countryCode;
    }
    selectCountryCodeValue = singleItem;

    isLoading(false);
    Get.back();
    searchCountryCodeList = countryCodeList;
    searchController.clear();
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    phoneNumberController.text = await userPreference.getStringFromPrefs(
        key: UserPreference.userMobileNoKey);
    prefsCountryDialCode = await userPreference.getStringFromPrefs(
        key: UserPreference.userCountryCodeKey);
    log('old phone Number : ${phoneNumberController.text}');
    log('prefsCountryDialCode : $prefsCountryDialCode');
    await getCountryCodesFunction();
  }

//List<CountryData> searchCountryCodeList = [];
//List<CountryData> countryCodeList = [];
// CountryData selectCountryCodeValue = CountryData();

// String finalMobileNumber = "";
//UserPreference userPreference = UserPreference();

// When select on country
/*  Future<void> getCountryCodesFunction() async {
    isLoading(true);
    // String url = ApiUrl.getCountryCodeApi;
    // log('Country Code List Api Url :$url');

    try {
      CountryListModel countryListModel = CountryListModel.fromJson(json.decode(CountryModel.countryList));
      countryCodeList.addAll(countryListModel.countryList);
      searchCountryCodeList = countryCodeList;
      selectCountryCodeValue = countryCodeList[0];
      countryCodeController.text = "${selectCountryCodeValue.emoji} "
          "${selectCountryCodeValue.dialCode} ${selectCountryCodeValue.code}";
    } catch (e) {
      log('getCountryCodesFunction Error :$e');
      rethrow;
    }

    isLoading(false);
  }

  Future<void> loginUsingMobileNumberFunction() async {
    isLoading(true);
    String url = ApiUrl.loginApi;
    log('loginUsingMobileNumberFunction Api Url : $url');

    try {
      // String countryCode = selectCountryCodeValue.split(" ")[1];
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // request.fields['phone'] = "$countryCode${phoneNumberController.text}";
      request.fields['phone'] = "${selectCountryCodeValue.dialCode}${phoneNumberController.text}";

      log('Fields : ${request.fields}');

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value : $value');

        LoginModel loginModel = LoginModel.fromJson(json.decode(value));

        if (loginModel.statusCode == 200) {
          // Set Mobile number & token in prefs
          await userPreference.setStringValueInPrefs(
            key: UserPreference.userMobileNoKey,
            value: phoneNumberController.text,
          );
          await userPreference.setStringValueInPrefs(
            key: UserPreference.userTokenKey,
            value: loginModel.verifyToken,
          );

          Get.to(
                () => VerifyCodeScreen(),
            arguments: [
              selectCountryCodeValue.dialCode,
              phoneNumberController.text.trim(),
              authAs,
            ],
          );
        } else if (loginModel.statusCode == 400) {
          Fluttertoast.showToast(msg: loginModel.msg);
        } else {
          Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      });
    } catch (e) {
      log('loginUsingMobileNumberFunction Error :e');
      rethrow;
    }

    isLoading(false);
  }

  // Continue Button Function
  Future<void> onContinueButtonClickFunction() async {
    if (formKey.currentState!.validate()) {
      // String finalMobileNumber = "";

      // List<String> countryNameAndCodeList = selectCountryCodeValue.value.split(" ");
      // String countryCode =
      //     countryNameAndCodeList[1].replaceAll("+", "").replaceAll("-", "");
      // log('countryCode :$countryCode');

      log('Mobile Number :${phoneNumberController.text.trim()}');

      finalMobileNumber = "${selectCountryCodeValue.dialCode}${phoneNumberController.text.trim()}";
      log('finalMobileNumber : $finalMobileNumber');

      if (authAs == AuthAs.register) {
        await loginUsingMobileNumberFunction();
      } else if (authAs == AuthAs.login) {
        await loginUsingMobileNumberFunction();
      }
    }
  }



  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    phoneNumberController.text = await userPreference.getStringFromPrefs(key: UserPreference.userMobileNoKey);
    await getCountryCodesFunction();
  }*/
}
