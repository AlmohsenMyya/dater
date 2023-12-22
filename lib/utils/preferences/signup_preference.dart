import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpPreference {
  static String signUpEmailKey = "signUpEmailKey"; // String
  static String signUpLocationKey = "signUpLocationKey"; // String
  static String signUpFNameKey = "signUpFNameKey"; // String
  static String userImage1Key = "userImage1Key"; // String
  static String userImage2Key = "userImage2Key"; // String
  static String userImage3Key = "userImage3Key"; // String
  static String userDobKey = "userDobKey"; // String
  static String userSexualityKey = "userSexualityKey"; // String
  static String userGenderKey = "userGenderKey"; // String
  static String targetGenderKey = "targetGenderKey"; // String
  static String userGoalKey = "userGoalKey"; // String
  static String userInterestKey = "userInterestKey"; // String
  static String isUserFirstTimeKey =
      "isUserFirstTimeKey"; // bool - Show SignUp & SignIn Button
  static String isShowMeGenderKey = "isShowMeGenderKey"; // String

  Future<void> clearSignUpDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(signUpEmailKey);
    prefs.remove(signUpLocationKey);
    prefs.remove(signUpFNameKey);
    prefs.remove(userImage1Key);
    prefs.remove(userImage2Key);
    prefs.remove(userImage3Key);
    prefs.remove(userDobKey);
    prefs.remove(userSexualityKey);
    prefs.remove(userGenderKey);
    prefs.remove(targetGenderKey);
    prefs.remove(userGoalKey);
    prefs.remove(userInterestKey);
    prefs.remove(isUserFirstTimeKey);


    setBoolValueInPrefs(key: isUserFirstTimeKey,value: true);
    prefs.setString(signUpEmailKey, "");
    prefs.setString(signUpLocationKey, "");
    prefs.setString(signUpFNameKey, "");
    prefs.setString(userImage1Key, "");
    prefs.setString(userImage2Key, "");
    prefs.setString(userImage3Key, "");
    prefs.setString(userDobKey, "");
    prefs.setString(userSexualityKey, "");
    prefs.setString(userGenderKey, "");
    prefs.setString(targetGenderKey, "");
    prefs.setString(userGoalKey, "");
    prefs.setString(userInterestKey, "");

    log("signUpEmailKey : ${prefs.getString(signUpEmailKey)}");
    log("signUpFNameKey : ${prefs.getString(signUpFNameKey)}");
    prefs.clear();

  }

  Future<void> setStringValueInPrefs(
      {required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    log('prefs value string value:${prefs.getString(key)}');
  }

  Future<void> setListValueInPrefs(
      {required String key, required List<String> value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
    log('prefs list value :${prefs.getStringList(key)}');
  }

  Future<String> getStringFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }

  Future<void> setBoolValueInPrefs(
      {required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    log('prefs value bool val :${prefs.getBool(key)}');
  }

  Future<bool> getBoolFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? true;
    return value;
  }

  updateUserProfileFunction({required String key, required String value}) {}
}
