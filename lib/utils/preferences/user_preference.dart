import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static String lastUpdatedSteps = 'lastUpdatedSteps'; //String
  static String lastUpdatedStepsDate = 'lastUpdatedStepsDate'; //String
  static String serviceForGroundRunning = 'lastUpdatedSteps'; //bool
  static String userMobileNoKey = "userMobileNoKey"; // String
  static String userCountryCodeKey = "userCountyCodeKey"; // string
  static String userTokenKey = "userTokenKey"; // This is temp token // String
  // static String userCountryDialCodeKey = "userCountryDialCodeKey"; // String
  static String userVerifyTokenKey =
      "userVerifyTokenKey"; // This is main token // String
  static String isUserCreatedKey = "isUserCreatedKey"; // bool
  static String isUserLoggedInKey = "isUserLoggedInKey"; // bool
  static String isSeeWhoLikesYouKey = "isSeeWhoLikesYouKey"; // String
  static String isragatherInKey = "isragatherInKey";
  static String isSuperLoveInKey = "isSuperLoveInKey";
  static String isLikeInKey = "isLikeInKey";
  static String completeRegister = "isCompleteRegister"; //bool

  /// For Profile Section
  static String nameKey = "nameKey"; // String
  static String userIdKey = "userIdKey"; // String
  static String profilePromptsKey = "profilePromptsKey"; // String
  static String bioKey = "bioKey"; // String
  static String verifiedKey = "verifiedKey"; // String
  static String homeTownKey = "homeTownKey"; // String
  static String distanceKey = "distanceKey"; // String
  static String ageKey = "ageKey"; // String
  static String activeTimeKey = "activeTimeKey"; // String
  static String genderKey = "genderKey"; // String
  // static String myBasicGenderValueKey = "myBasicGenderValueKey";
  static String isShowMeGenderKey = "isShowMeGenderKey";
  static String workKey = "workKey"; // String
  static String educationKey = "educationKey"; // String
  static String heightKey = "heightKey"; // String
  static String exerciseKey = "exerciseKey"; // String
  static String smokingKey = "smokingKey"; // String
  static String drinkingKey = "drinkingKey"; // String
  static String politicsKey = "politicsKey"; // String
  static String religionKey = "religionKey"; // String
  static String starSignKey = "starSignKey"; // String
  static String kidsKey = "kidsKey"; // String
  static String interestKey = "interestKey"; // String
  static String imagesKey = "imagesKey"; // String
  static String listOfImageKey = "listOfImageKey";
  static String listOfLanguageKey = "listOfLanguageKey";
  static String editImagesKey = "editImagesKey"; // String
  static String myBasicWorkValueKey = "myBasicWorkValueKey";
  static String myBasicEducationValueKey = "myBasicEducationValueKey";
  static String myBasicHomeTownValueKey = "myBasicHomeTownValueKey";
  static String myBasicLookingForValueKey = "myBasicLookingForValueKey";

  Future<void> clearUserAllDataFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(userMobileNoKey);
    prefs.remove(userTokenKey);
    prefs.remove(userVerifyTokenKey);
    prefs.remove(isUserLoggedInKey);
    prefs.remove(lastUpdatedSteps);
    prefs.remove(lastUpdatedStepsDate);

    prefs.setString(lastUpdatedSteps, '');
    prefs.setString(lastUpdatedStepsDate, '');
    prefs.setString(userTokenKey, '');
    prefs.setString(userVerifyTokenKey, '');
    prefs.setBool(isUserLoggedInKey, false);
    prefs.clear();

  }


  // Set String Type List
  Future<void> setListOfStringInPrefs({required List<String> value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(listOfImageKey, value);
  }

  // Set Language String Type List
  Future<void> setLanguageListOfStringInPrefs(
      {required List<String> value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(listOfLanguageKey, value);
  }

  // Set String value
  Future<void> setStringValueInPrefs(
      {required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    log('prefs value signup :${prefs.getString(key)}');
  }

  // Get String value
  Future<String> getStringFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(key) ?? "";
    return value;
  }

  // Set Bool value
  Future<void> setBoolValueInPrefs(
      {required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    log('prefs value :${prefs.getBool(key)}');
  }

  // Get Bool value
  Future<bool> getBoolFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? true;
    return value;
  }

  // Get User loggedIn bool value
  Future<bool> getUserLoggedInFromPrefs({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? false;
    return value;
  }
}
