import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/app_images.dart';
import '../model/profile_screen_models/basic_model.dart';
import '../model/profile_screen_models/logged_in_user_details_model.dart';
import '../utils/preferences/user_preference.dart';

class ProfileScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  // double progressValue = 40;

  UserPreference userPreference = UserPreference();

  UserDetails? userDetails;

  // Profile Show Variables
  RxString userName = "".obs;

  // RxString userProfilePrompts = "".obs;
  RxString userBio = "".obs;
  RxString userVerified = "".obs;
  RxString userHomeTown = "".obs;
  RxString userCountry = "".obs;
  RxString userLookingFor = "".obs;
  RxString userDistance = "".obs;
  RxString userAge = "".obs;
  RxString userActiveTime = "".obs;
  RxString userGender = "".obs;
  RxString userWork = "".obs;
  RxString userEducation = "".obs;
  RxString userHeight = "".obs;
  RxString userExercise = "".obs;
  RxString userSmoking = "".obs;
  RxString userDrinking = "".obs;
  RxString userPolitics = "".obs;
  RxString userReligion = "".obs;
  RxString userKids = "".obs;
  RxString userStarSign = "".obs;
  RxDouble userPercentage = 0.0.obs;

  List<BasicModel> basicList = [];
  List<BasicModel> interestList = [];
  List<UserImages> userImages = [];
  List<UserImages> userSubImagesList =
      []; // Remove first 3 index images other all images save in this list.
  List<String> languageList = [];
  List<Prompt> promptsList = [];

  // Get User Profile
  Future<void> getUserDetailsFunction() async {
    isLoading(true);
    String url = ApiUrl.getLoggedInUserProfileApi;
    log('getUserDetailsFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      log('User Profile verifyToken :$verifyToken');
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) async {
        log("getUserDetailsFunction Api value :$value");

        LoggedInUserDetailsModel loggedInUserDetailsModel =
            LoggedInUserDetailsModel.fromJson(json.decode(value));
        successStatus.value = loggedInUserDetailsModel.statusCode;

        if (successStatus.value == 200) {
          userDetails = loggedInUserDetailsModel.msg[0];

          userName.value = loggedInUserDetailsModel.msg[0].name;
          // userProfilePrompts.value = loggedInUserDetailsModel.msg[0].profilePrompts!;
          userBio.value = loggedInUserDetailsModel.msg[0].bio;
          userVerified.value = loggedInUserDetailsModel.msg[0].verified;
          userHomeTown.value = loggedInUserDetailsModel.msg[0].homeTown;
          // userLookingFor.value = loggedInUserDetailsModel.msg[0].basic.;
          userDistance.value = loggedInUserDetailsModel.msg[0].distance;
          userAge.value = loggedInUserDetailsModel.msg[0].age;
          userActiveTime.value = loggedInUserDetailsModel.msg[0].activeTime;
          userGender.value = loggedInUserDetailsModel.msg[0].basic.gender;
          userWork.value = loggedInUserDetailsModel.msg[0].basic.work;
          userEducation.value = loggedInUserDetailsModel.msg[0].basic.education;
          userHeight.value = loggedInUserDetailsModel.msg[0].basic.height;
          userExercise.value = loggedInUserDetailsModel.msg[0].basic.exercise;
          userSmoking.value = loggedInUserDetailsModel.msg[0].basic.smoking;
          userDrinking.value = loggedInUserDetailsModel.msg[0].basic.drinking;
          userPolitics.value = loggedInUserDetailsModel.msg[0].basic.politics;
          userReligion.value = loggedInUserDetailsModel.msg[0].basic.religion;
          userStarSign.value = loggedInUserDetailsModel.msg[0].starSign;
          userKids.value = loggedInUserDetailsModel.msg[0].basic.kids;
          userPercentage.value = double.parse(
              loggedInUserDetailsModel.msg[0].percentage.toString());
          userCountry.value = loggedInUserDetailsModel.msg[0].country;

          promptsList.clear();
          if (loggedInUserDetailsModel.msg[0].prompts.isNotEmpty) {
            promptsList.addAll(loggedInUserDetailsModel.msg[0].prompts);
          }

          setBasicListFunction();
          await setInterestListFunction(
              loggedInUserDetailsModel.msg[0].interest);

          /// Set User Images in local list
          userImages.clear();
          for (var element in loggedInUserDetailsModel.msg[0].images) {
            userImages.add(element);
          }

          // When userImage List Length more then 3
          userSubImagesList.clear();
          if (userImages.length > 3) {
            for (int i = 3; i < userImages.length; i++) {
              userSubImagesList.add(userImages[i]);
            }
          }
          log('userImages Length : ${userImages.length}');

          /// Set Language in local list
          if (loggedInUserDetailsModel.msg[0].languages.isNotEmpty) {
            languageList.addAll(loggedInUserDetailsModel.msg[0].languages);
          }

          await setLoggedInUserDetailsInPrefs(loggedInUserDetailsModel.msg[0]);
        } else {
          log('getUserDetailsFunction Else');
        }
      });
    } catch (e) {
      log('getUserDetailsFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  /// Clear All Things - When coming from edit profile screen
  void clearOldUserDataFunction() {
    basicList.clear();
    interestList.clear();
    userImages.clear();
    languageList.clear();
  }

  /// Set Basic Details
  void setBasicListFunction() {

    basicList.add(BasicModel(
        image: AppImages.heightImage, name: "${userHeight.value} cm"));
    // basicList.add(
    //     BasicModel(image: AppImages.educationImage, name: userEducation.value));
    basicList
        .add(BasicModel(image: AppImages.genderImage, name: userGender.value));
    // basicList.add(BasicModel(
    //     image: AppImages.homeTownImage, name: userHomeTown.value));
    basicList.add(
        BasicModel(image: AppImages.drinkingImage, name: userDrinking.value));
    basicList.add(BasicModel(image: AppImages.kidsImage, name: userKids.value));
    basicList.add(
        BasicModel(image: AppImages.exerciseImage, name: userExercise.value));
    basicList.add(
        BasicModel(image: AppImages.smokingImage, name: userSmoking.value));
    basicList.add(
        BasicModel(image: AppImages.starsignImage, name: userStarSign.value));
    // basicList.add(
    //     BasicModel(image: AppImages.educationImage, name: userEducation.value));
    basicList.add(
        BasicModel(image: AppImages.religionImage, name: userReligion.value));
    basicList.add(
        BasicModel(image: AppImages.politicsImage, name: userPolitics.value));
  }

  /// Set Interest in local & Prefs
  Future<void> setInterestListFunction(List<Interest> interest) async {
    if (interest.isNotEmpty) {
      for (var element in interest) {
        interestList.add(BasicModel(image: element.image, name: element.name));
      }

      /// Set Interest List in Prefs
      List<String> temp = [];
      for (var value in interestList) {
        temp.add(value.name);
      }
      String temp2 = temp
          .toString()
          .substring(1, temp.toString().length - 1)
          .replaceAll(" ", "");
      log('temp2 : $temp2');
      await userPreference.setStringValueInPrefs(
          key: UserPreference.interestKey, value: temp2);
    }
  }

  /// Set User Images in Prefs
  Future<void> setUserImagesInPrefsFunction() async {}

  /*Future<void> setUserInterestFunction(List<Interest> interestList) async {
    List<String> temp = [];
    if(interestList.isNotEmpty) {
      for(var value in interestList) {
        temp.add(value.name);
      }
      String temp2 = temp.toString().substring(1, temp.length - 1).replaceAll(" ", "");
      log('temp2 : $temp2');
      await userPreference.setStringValueInPrefs(key: UserPreference.interestKey, value: temp2);
    }
  }*/

  /// Set Usr Details in Prefs
  Future<void> setLoggedInUserDetailsInPrefs(UserDetails userDetails) async {
    await userPreference.setStringValueInPrefs(
        key: UserPreference.nameKey, value: userDetails.name);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.userIdKey, value: userDetails.id);
    // await userPreference.setStringValueInPrefs(
    //     key: UserPreference.profilePromptsKey,
    //     value: userDetails.profilePrompts!);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.bioKey, value: userDetails.bio);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.verifiedKey, value: userDetails.verified);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.homeTownKey, value: userDetails.homeTown);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.distanceKey, value: userDetails.distance);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.ageKey, value: userDetails.age);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.activeTimeKey, value: userDetails.activeTime);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.genderKey, value: userDetails.basic.gender);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.workKey, value: userDetails.basic.work);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.educationKey, value: userDetails.basic.education);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.heightKey, value: userDetails.basic.height);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.exerciseKey, value: userDetails.basic.exercise);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.smokingKey, value: userDetails.basic.smoking);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.drinkingKey, value: userDetails.basic.drinking);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.politicsKey, value: userDetails.basic.politics);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.religionKey, value: userDetails.basic.religion);
    await userPreference.setStringValueInPrefs(
        key: UserPreference.kidsKey, value: userDetails.basic.kids);

    // String bio = await userPreference.getStringFromPrefs(key: UserPreference.bioKey);
    // String distance = await userPreference.getStringFromPrefs(key: UserPreference.distanceKey);
    // String age = await userPreference.getStringFromPrefs(key: UserPreference.ageKey);
    // log('Prefs Bio : $bio');
    // log('Prefs distance : $distance');
    // log('Prefs age : $age');
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    basicList = [];
    interestList = [];
    userImages = [];
    userSubImagesList =
        []; // Remove first 3 index images other all images save in this list.
    languageList = [];
    promptsList = [];
    await getUserDetailsFunction();
  }

/*Future<void> setDataInUserVariablesFunction() async {
    isLoading(true);
    // userProfilePrompts.value = await userPreference.getStringFromPrefs(key: UserPreference.profilePromptsKey);
    userBio.value = await userPreference.getStringFromPrefs(key: UserPreference.bioKey);
    // Set Height Value in Parameter & Add in list
    userHeight.value = await userPreference.getStringFromPrefs(key: UserPreference.heightKey);
    if(basicList.isNotEmpty) {
      basicList.removeAt(0);
      basicList.insert(
        0,
        BasicModel(
            image: AppImages.heightImage,
            name: "${userHeight.value.split('.')[0]} cm"),
      );
    }

    // Set Exercise Value in Parameter & Add in list
    if(basicList.isNotEmpty) {
      userExercise.value =
      await userPreference.getStringFromPrefs(key: UserPreference.exerciseKey);
      basicList.removeAt(1);
      basicList.insert(
        1,
        BasicModel(image: AppImages.exerciseImage, name: userExercise.value),
      );
    }

    // Set Drinking Value in Parameter & Add in list
    if(basicList.isNotEmpty) {
      userDrinking.value =
      await userPreference.getStringFromPrefs(key: UserPreference.drinkingKey);
      basicList.removeAt(2);
      basicList.insert(
        2,
        BasicModel(image: AppImages.drinkingImage, name: userDrinking.value),
      );
    }

    // Set Smoking Value in Parameter & Add in list
    if(basicList.isNotEmpty) {
      userSmoking.value =
      await userPreference.getStringFromPrefs(key: UserPreference.smokingKey);
      basicList.removeAt(3);
      basicList.insert(
        3,
        BasicModel(image: AppImages.smokingImage, name: userSmoking.value),
      );
    }

    // Set Kids Value in Parameter & Add in list
    if(basicList.isNotEmpty) {
      userKids.value =
      await userPreference.getStringFromPrefs(key: UserPreference.kidsKey);
      basicList.removeAt(4);
      basicList.insert(
          4, BasicModel(image: AppImages.kidsImage, name: userKids.value));
    }

    isLoading(false);
  }*/
}
