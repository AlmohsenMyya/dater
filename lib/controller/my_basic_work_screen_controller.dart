import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/messages.dart';
import 'package:dater/utils/preferences/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';

class MyBasicWorkScreenController extends GetxController {

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController companyFieldController = TextEditingController();

  UserPreference userPreference = UserPreference();


  Future<void> doneButtonClick() async {
    if(formKey.currentState!.validate()) {
      // String work = "${titleFieldController.text.trim()} at ${companyFieldController.text.trim()}";
      String work = titleFieldController.text.trim();
      log('work :$work');
      await saveWorkFunction(
        key: AppMessages.workApiText,
        value: work,
      );
    }
  }


  Future<void> saveWorkFunction(
      {required String key, required String value}) async {
    isLoading(true);
    String url = ApiUrl.completeSignUpApi;
    log('saveWorkFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields[key] = value;

      log('Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value1) async {
        log('value : $value1');
        CompleteSignupModel completeSignupModel =
        CompleteSignupModel.fromJson(json.decode(value1));
        successStatus.value = completeSignupModel.statusCode;

        if (successStatus.value == 200) {
          log('Update User Profile Success : $key & $value');
          await userPreference.setStringValueInPrefs(
            key: UserPreference.myBasicWorkValueKey,
            value: value,
          );
          Get.back();
        } else {
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('setSexualityFunction Error :$e');
      rethrow;
    }
  }




}