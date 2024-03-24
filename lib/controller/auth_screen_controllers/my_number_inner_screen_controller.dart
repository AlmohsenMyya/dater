import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:dater/constants/enums.dart';
import 'package:dater/constants/messages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/authentication_model/country_code_list_model/country_code_list.dart';
import '../../model/authentication_model/country_code_list_model/country_code_list_model.dart';
import '../../model/authentication_model/login_screen_model/login_model.dart';
import '../../screens/authentication_screen/verify_code_screen/verify_code_screen.dart';
import '../../utils/preferences/user_preference.dart';

class MyNumberInnerScreenController extends GetxController {
  AuthAs authAs = Get.arguments[0];
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController referralNumber = TextEditingController();
  List<CountryData> searchCountryCodeList = [];
  List<CountryData> countryCodeList = [];
  CountryData selectCountryCodeValue = CountryData();

  String finalMobileNumber = "";
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

      String temp = await userPreference.getStringFromPrefs(
          key: UserPreference.userCountryCodeKey);

      if (authAs == AuthAs.login) {
        selectCountryCodeValue = searchCountryCodeList
                .firstWhereOrNull((element) => element.dialCode == temp) ??
            countryCodeList[0];
      } else {
        selectCountryCodeValue = countryCodeList[0];
      }
      countryCodeController.text = "${selectCountryCodeValue.emoji} "
          "${selectCountryCodeValue.dialCode} ${selectCountryCodeValue.code}";
      /*if (response.statusCode == 200) {
        String mainResponse = response.body.toString();
        // Json Response convert into List
        List<String> singleObjectList =
            mainResponse.substring(1, mainResponse.length - 1).split(", ");

        // Make single object for all positions in list
        for (var item in singleObjectList) {
          List<String> tempSingleItem = item.split(": ");
          String fString = tempSingleItem[0] == ""
              ? ""
              : tempSingleItem[0].substring(1, tempSingleItem[0].length - 1);
          String lString = tempSingleItem[1] == ""
              ? ""
              : tempSingleItem[1].substring(1, tempSingleItem[1].length - 1);
          countryCodeList.add("$fString $lString");
        }
        log('countryCodeList : ${countryCodeList.length}');
      }
      else {
        log('Status code : ${response.statusCode}');
      }*/
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
      request.fields['phone'] =
          "${selectCountryCodeValue.dialCode}${phoneNumberController.text}";

      log('Fields : ${request.fields}');

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('loginUsingMobileNumberFunction value : $value');

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
          await userPreference.setStringValueInPrefs(
              key: UserPreference.userCountryCodeKey,
              value: selectCountryCodeValue.dialCode.toString());

          Get.to(
            () => VerifyCodeScreen(),
            arguments: [
              selectCountryCodeValue.dialCode,
              phoneNumberController.text.trim(),
              loginModel.msg.toLowerCase() ==
                      "Account created successfully".toLowerCase()
                  ? AuthAs.register
                  : AuthAs.login,
              ComingFrom.registerScreen,
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
  Future<void> loginUsingEmailFunction() async {
    isLoading(true);
    String url = ApiUrl.loginByEmailApi;
    log('loginUsingEmailFunction Api Url : $url');

    try {
      // String countryCode = selectCountryCodeValue.split(" ")[1];
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // request.fields['phone'] = "$countryCode${phoneNumberController.text}";
      request.fields['email'] =
      // "${selectCountryCodeValue.dialCode}"
          "${phoneNumberController.text}";

      log('Fields : ${request.fields}');

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('loginUsingEmailFunction value : $value');

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
          await userPreference.setStringValueInPrefs(
              key: UserPreference.userCountryCodeKey,
              value: selectCountryCodeValue.dialCode.toString());

          Get.to(
                () => VerifyCodeScreen(),
            arguments: [
              selectCountryCodeValue.dialCode,
              phoneNumberController.text.trim(),
              loginModel.msg.toLowerCase() ==
                  "Account created successfully".toLowerCase()
                  ? AuthAs.register
                  : AuthAs.login,
              ComingFrom.registerScreen,
            ],
          );
        } else if (loginModel.statusCode == 400) {
          Fluttertoast.showToast(msg: loginModel.msg);
        } else {
          Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      });
    } catch (e) {
      log('loginUsingMobileNumberFunction Error :$e');
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

      finalMobileNumber =
          // "${selectCountryCodeValue.dialCode}"
              "${phoneNumberController.text.trim()}";
      log('finalMobileNumber : $finalMobileNumber');

      if (authAs == AuthAs.register) {
        await loginUsingEmailFunction();
      } else if (authAs == AuthAs.login) {
        await loginUsingEmailFunction();
      }
    }
  }

  onCountrySelectFunction(CountryData singleItem) {
    isLoading(true);
    countryCodeController.text =
        "${singleItem.emoji} ${singleItem.dialCode} ${singleItem.code}";
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

  initMethod() async {
    if (authAs == AuthAs.login) {
      phoneNumberController.text = await userPreference.getStringFromPrefs(
          key: UserPreference.userMobileNoKey);
    }
    await userPreference.setStringValueInPrefs(
      key: UserPreference.isYourAd1FirtsTime,
      value: "yes",
    );
    await userPreference.setStringValueInPrefs(
      key: UserPreference.isYourAd2FirtsTime,
      value: "yes",
    );
    await userPreference.setStringValueInPrefs(
      key: UserPreference.isYourAd3FirtsTime,
      value: "yes",
    );
    await getCountryCodesFunction();
  }
}
