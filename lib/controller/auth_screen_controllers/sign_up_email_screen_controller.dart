import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../constants/api_url.dart';
import '../../constants/messages.dart';
import '../../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../../screens/authentication_screen/username_screen/username_screen.dart';
import '../../utils/preferences/signup_preference.dart';
import '../../utils/preferences/user_preference.dart';
import 'package:http/http.dart' as http;

class SignUpEmailScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxInt successStatus = 0.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextFieldController = TextEditingController();

  SignUpPreference signUpPreference = SignUpPreference();
  UserPreference userPreference = UserPreference();

  // Continue button click function
  Future<void> continueButtonClickFunction() async {
    if (formKey.currentState!.validate()) {
      await updateUserProfileEmailFunction(
        key: AppMessages.emailApiText,
        value: emailTextFieldController.text.toLowerCase().trim(),
      );
      log("emailTextFieldController.text: ${emailTextFieldController.text}");
    }
  }

  Future<void> updateUserProfileEmailFunction(
      {required String key, required String value}) async {
    String url = ApiUrl.completeSignUpApi;
    log('Update User Profile Api Url : $url');

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

          Fluttertoast.showToast(msg: completeSignupModel.msg);
          Get.to(() => UserNameScreen());
        } else {
          Fluttertoast.showToast(msg: completeSignupModel.msg);
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('updateUserProfileFunction Error :$e');
      rethrow;
    }
  }
}
