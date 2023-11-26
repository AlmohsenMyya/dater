import 'dart:convert';
import 'dart:developer';
import 'package:dater/constants/api_url.dart';
import 'package:dater/utils/preferences/signup_preference.dart';
import 'package:dater/utils/preferences/user_preference.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/settings_screen_models/delete_account_model.dart';
import '../model/settings_screen_models/referral_model.dart';
import '../screens/authentication_screen/login_screen/login_screen.dart';



class SettingsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  RxString referralNumber = "".obs;

  String userVerified = "";

  UserPreference userPreference = UserPreference();
  SignUpPreference signUpPreference = SignUpPreference();

  /// Get Referral Code
  Future<void> getUserReferralCodeFunction() async {
    isLoading(true);
    String url = ApiUrl.getReferralCodeApi;
    log('getUserReferralCodeFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value : $value');
        ReferralModel referralModel =
            ReferralModel.fromJson(json.decode(value));
        successStatus.value = referralModel.statusCode;

        if (successStatus.value == 200) {
          referralNumber.value = referralModel.msg;
        } else {
          log('getUserReferralCodeFunction Else');
        }
      });
    } catch (e) {
      log('getUserReferralCodeFunction Error :$e');
      rethrow;
    }
    // isLoading(false);
    // await getShowMeGenderValueFromPrefs();
  }

  /// Copy Text Function
  Future<void> copyTextFunction() async {
    await Clipboard.setData(ClipboardData(text: referralNumber.value));
    Fluttertoast.showToast(msg: "Copied!");
  }

  logOutButtonFunction() async {
    await userPreference.clearUserAllDataFromPrefs();
    await signUpPreference.clearSignUpDataFromPrefs();
    Get.offAll(() => LoginInScreen());
  }

  /// Delete User Account
  Future<void> deleteAccountFunction() async {
    isLoading(true);
    String url = ApiUrl.deleteUserAccountApi;
    log('deleteAccountFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value :$value');

        DeleteAccountModel deleteAccountModel =
            DeleteAccountModel.fromJson(json.decode(value));
        successStatus.value = deleteAccountModel.statusCode;

        if (successStatus.value == 200) {
          Fluttertoast.showToast(msg: deleteAccountModel.msg);
          await logOutButtonFunction();
        } else if (successStatus.value == 400) {
          Get.back();
          Fluttertoast.showToast(msg: deleteAccountModel.msg);
          await logOutButtonFunction();
        } else {
          log('deleteAccountFunction Else');
        }
      });
    } catch (e) {
      log('deleteAccountFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }



  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    userVerified = await userPreference.getStringFromPrefs(key: UserPreference.verifiedKey);
    log('userVerified :$userVerified');
    await getUserReferralCodeFunction();
  }
}
