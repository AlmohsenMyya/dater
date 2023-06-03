import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dater/model/star_sign_screen_model/save_star_sign_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants/api_url.dart';
import '../constants/enums.dart';
import '../constants/messages.dart';
import '../model/authentication_model/add_user_photo_screen_model/user_photo_upload_screen.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../model/profile_screen_models/delete_image_model.dart';
import '../model/profile_screen_models/logged_in_user_details_model.dart';
import '../model/profile_screen_models/upload_image_model.dart';
import '../model/saved_data_model/saved_data_model.dart';
import '../utils/preferences/user_preference.dart';

class EditProfileScreenController extends GetxController {
  // UserDetails userDetails = Get.arguments[0];
  // final profileScreenController = Get.find<ProfileScreenController>();

  UserDetails? userDetails;

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;
  final ImagePicker imagePicker = ImagePicker();

  MoreAboutMe exerciseValue = MoreAboutMe.hidden;
  MoreAboutMe drinkingValue = MoreAboutMe.hidden;
  MoreAboutMe smokingValue = MoreAboutMe.hidden;
  MoreAboutMe kidsValue = MoreAboutMe.hidden;

  List<Interest> interestList = [];
  List<String> languageList = [];

  String politics = "";
  String religion = "";
  String education = "";
  String starSign = "";
  String gender = "";
  String work = "";
  String homeTown = "";
  String lookingFor = "";
  int userPercentage = 0;
  TextEditingController profilePromptsController = TextEditingController();
  TextEditingController myBioController = TextEditingController();

  TextEditingController myNameController = TextEditingController();

  UserPreference userPreference = UserPreference();

  // RxList<File> captureImageList = RxList<File>();
  RxList<UploadUserImage> captureImageList = RxList<UploadUserImage>();
  RxDouble startVal = 00.0.obs;
  RxDouble endVal = 80.0.obs;
  File? file;

  RxBool onSelected = false.obs;
  List<Prompt> promptsList = [];

  /// Image Select From Gallery
  getImageFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      captureImageList.add(UploadUserImage(
          id: "", imageUrl: pickedFile.path, isImageFromNetwork: false));
      File selectedFile = File(pickedFile.path);
      await uploadImageFunction(selectedFile);
    }
    log('captureImageList Length : ${captureImageList.length}');
    loadUI();
  }

  /// Upload Image function
  Future<void> uploadImageFunction(File image) async {
    isLoading(true);
    String url = ApiUrl.uploadPhotoApi;
    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['fileKey'] = "file";
      request.headers['chunkedMode'] = "false";
      request.headers['mimeType'] = "multipart/form-data";
      request.fields['token'] = verifyToken;
      request.files.add(await http.MultipartFile.fromPath("file", image.path));

      log('All Fields : ${request.fields}');
      log('All files : ${request.files}');
      log('All headers : ${request.headers}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value :$value');
        UserPhotoUploadModel userPhotoUploadModel =
            UserPhotoUploadModel.fromJson(json.decode(value));

        if (userPhotoUploadModel.statusCode == 200) {
          Fluttertoast.showToast(msg: userPhotoUploadModel.msg);
          await getUserDetailsFunction();
        } else if (userPhotoUploadModel.statusCode == 400) {
          Fluttertoast.showToast(msg: userPhotoUploadModel.msg);
        } else {
          Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      });
    } catch (e) {
      log('uploadImageFunction Error :$e');
      rethrow;
    }
  }

  /// Delete User Image Function
  void deleteUserImageFunction(int i) {
    captureImageList.removeAt(i);
  }

  /// Set Profile Prompts in Prefs
  Future<void> setProfilePromptsFunction() async {
    await userPreference.setStringValueInPrefs(
        key: UserPreference.profilePromptsKey,
        value: profilePromptsController.text.trim());
    String prompts = await userPreference.getStringFromPrefs(
        key: UserPreference.profilePromptsKey);

    await updateUserProfileFunction(
        key: AppMessages.profilePromptsApiText, value: prompts);
    log('Prompts : $prompts');
  }

  /// Set User Bio in Prefs
  Future<void> setUserBioFunction() async {
    await userPreference.setStringValueInPrefs(
        key: UserPreference.bioKey, value: myBioController.text.trim());
    String bio =
        await userPreference.getStringFromPrefs(key: UserPreference.bioKey);
    log('Bio : $bio');
    await updateUserProfileFunction(key: AppMessages.bioApiText, value: bio);
  }

  Future<void> setUserNameFunction() async {
    await userPreference.setStringValueInPrefs(
        key: UserPreference.nameKey, value: myNameController.text.trim());
    String name =
        await userPreference.getStringFromPrefs(key: UserPreference.nameKey);
    log('My Name : $name');
    await updateUserProfileFunction(key: AppMessages.fNameApiText, value: name);
  }

  /// Set User height in Prefs
  Future<void> setUserHeightFunction() async {
    await userPreference.setStringValueInPrefs(
        key: UserPreference.heightKey, value: endVal.toString());
    String height =
        await userPreference.getStringFromPrefs(key: UserPreference.heightKey);
    log('Height : $height');
    await updateUserProfileFunction(
        key: AppMessages.heightApiText, value: height.split('.')[0].toString());
  }

  /// Set Exercise Modules
  Future<void> setExerciseFunction(MoreAboutMe selectedValue) async {
    String value = selectedValue == MoreAboutMe.no
        ? "no"
        : selectedValue == MoreAboutMe.yes
            ? "yes"
            : selectedValue == MoreAboutMe.sometimes
                ? "sometimes"
                : "hidden";
    await userPreference.setStringValueInPrefs(
        key: UserPreference.exerciseKey, value: value);
    await updateUserProfileFunction(
        key: AppMessages.exerciseApiText, value: value.toLowerCase().trim());
  }

  /// Set Drinking Modules
  Future<void> setDrinkingFunction(MoreAboutMe selectedValue) async {
    String value = selectedValue == MoreAboutMe.no
        ? "no"
        : selectedValue == MoreAboutMe.yes
            ? "yes"
            : selectedValue == MoreAboutMe.sometimes
                ? "socially"
                : "hidden";

    await userPreference.setStringValueInPrefs(
        key: UserPreference.drinkingKey, value: value);
    await updateUserProfileFunction(
        key: AppMessages.drinkingApiText, value: value.toLowerCase().trim());
  }

  /// Set Smoking Modules
  Future<void> setSmokingFunction(MoreAboutMe selectedValue) async {
    String value = selectedValue == MoreAboutMe.no
        ? "no"
        : selectedValue == MoreAboutMe.yes
            ? "yes"
            : selectedValue == MoreAboutMe.sometimes
                ? "socially"
                : "hidden";
    await userPreference.setStringValueInPrefs(
        key: UserPreference.smokingKey, value: value);

    await updateUserProfileFunction(
        key: AppMessages.smokingApiText, value: value.toLowerCase().trim());
  }

  /// Set Kids Modules
  Future<void> setKidsFunction(MoreAboutMe selectedValue) async {
    String value = selectedValue == MoreAboutMe.no
        ? "no"
        : selectedValue == MoreAboutMe.yes
            ? "yes"
            : selectedValue == MoreAboutMe.sometimes
                ? "Someday"
                : "hidden";
    await userPreference.setStringValueInPrefs(
        key: UserPreference.kidsKey, value: value);
    await updateUserProfileFunction(
        key: AppMessages.kidsApiText, value: value.toLowerCase().trim());
  }

  /// User Profile Update API Integrate
  Future<void> updateUserProfileFunction(
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
        } else {
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('updateUserProfileFunction Error :$e');
      rethrow;
    }
  }

  /// Get User Profile From API
  Future<void> getUserDetailsFunction() async {
    isLoading(true);
    String url = ApiUrl.getLoggedInUserProfileApi;
    log('getUserDetailsFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      log('verifyToken :$verifyToken');
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) async {
        log("value :$value");

        LoggedInUserDetailsModel loggedInUserDetailsModel =
            LoggedInUserDetailsModel.fromJson(json.decode(value));
        successStatus.value = loggedInUserDetailsModel.statusCode;

        // log("politics $politics");
        if (successStatus.value == 200) {
          userDetails = loggedInUserDetailsModel.msg[0];

          politics = userDetails!.basic.politics;
          religion = userDetails!.basic.religion;
          education = userDetails!.basic.education;
          starSign = userDetails!.starSign;
          gender = userDetails!.basic.gender;
          work = userDetails!.basic.work;
          userPercentage = userDetails!.percentage;
          homeTown = userDetails!.homeTown;
          lookingFor = userDetails!.basic.lookingFor;

          promptsList.clear();
          if (loggedInUserDetailsModel.msg[0].prompts.isNotEmpty) {
            promptsList.addAll(loggedInUserDetailsModel.msg[0].prompts);
          }

          captureImageList.clear();

          /// Set User Network Images
          for (var value in userDetails!.images) {
            captureImageList.add(UploadUserImage(
                id: value.id,
                imageUrl: value.imageUrl,
                isImageFromNetwork: true));
          }

          /// Set User Interest
          interestList.clear();
          for (Interest value in userDetails!.interest) {
            interestList.add(value);
          }
          // profilePromptsController.text = userDetails!.profilePrompts!;
          myBioController.text = userDetails!.bio;
          endVal.value = double.parse(userDetails!.basic.height);

          languageList.clear();
          if (loggedInUserDetailsModel.msg[0].languages.isNotEmpty) {
            languageList.addAll(loggedInUserDetailsModel.msg[0].languages);
          }

          getAndSetExerciseValue(); // Getting from mobile screen
          getAndSetDrinkingValue();
          getAndSetSmokingValue();
          getAndSetKidsValue();
          await setUserImagesInPrefs();

          // userName.value = loggedInUserDetailsModel.msg[0].name;
          // userProfilePrompts.value =
          // loggedInUserDetailsModel.msg[0].profilePrompts!;
          // userBio.value = loggedInUserDetailsModel.msg[0].bio;
          // userVerified.value = loggedInUserDetailsModel.msg[0].verified;
          // userHomeTown.value = loggedInUserDetailsModel.msg[0].homeTown;
          // userDistance.value = loggedInUserDetailsModel.msg[0].distance;
          // userAge.value = loggedInUserDetailsModel.msg[0].age;
          // userActiveTime.value = loggedInUserDetailsModel.msg[0].activeTime;
          // userGender.value = loggedInUserDetailsModel.msg[0].basic.gender;
          // userWork.value = loggedInUserDetailsModel.msg[0].basic.work;
          // userEducation.value = loggedInUserDetailsModel.msg[0].basic.education;
          // userHeight.value = loggedInUserDetailsModel.msg[0].basic.height;
          // userExercise.value = loggedInUserDetailsModel.msg[0].basic.exercise;
          // userSmoking.value = loggedInUserDetailsModel.msg[0].basic.smoking;
          // userDrinking.value = loggedInUserDetailsModel.msg[0].basic.drinking;
          // userPolitics.value = loggedInUserDetailsModel.msg[0].basic.politics;
          // userReligion.value = loggedInUserDetailsModel.msg[0].basic.religion;
          // userKids.value = loggedInUserDetailsModel.msg[0].basic.kids;

          // setBasicListFunction();
          // await setInterestListFunction(
          //     loggedInUserDetailsModel.msg[0].interest);
          //
          // /// Set User Images in local list
          // for (var element in loggedInUserDetailsModel.msg[0].images) {
          //   userImages.add(element.imageUrl);
          // }
          // log('userImages Length : ${userImages.length}');
          //
          // await setLoggedInUserDetailsInPrefs(loggedInUserDetailsModel.msg[0]);
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

  /// Delete User Photo
  Future<void> deleteUserImagesFunction(
      {required String id, required int index}) async {
    String url = ApiUrl.deleteUserPhotoApi;
    log('deleteUserImagesFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['image_id'] = id;

      log('Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value1) async {
        log('value1 : $value1');

        DeleteImageModel deleteImageModel =
            DeleteImageModel.fromJson(json.decode(value1));

        successStatus.value = deleteImageModel.statusCode;
        if (successStatus.value == 200) {
          Fluttertoast.showToast(msg: deleteImageModel.msg);
          captureImageList.removeAt(index);
        } else {
          log('deleteUserImagesFunction Else');
        }
      });
    } catch (e) {
      log('deleteUserImagesFunction Error :$e');
      rethrow;
    }
    loadUI();
  }

  /// Delete Prompts
  Future<void> deletePromptsFunction(
      {required String promptsId, required int index}) async {
    isLoading(true);
    String url = ApiUrl.setPromptsApi;
    log('deletePromptsFunction Api Url :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['prompt_question_id'] = promptsId;
      request.fields['action'] = "remove";

      log('deletePromptsFunction Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value1) async {
        log('value1 : $value1');
        SaveStarSignModel deletePromptsModel =
            SaveStarSignModel.fromJson(json.decode(value1));

        successStatus.value = deletePromptsModel.statusCode;

        if (successStatus.value == 200) {
          promptsList.removeAt(index);
          Get.back();
          loadUI();
        } else {
          log('deletePromptsFunction Else');
        }
      });
    } catch (e) {
      log('deletePromptsFunction Error :$e');
      rethrow;
    }
  }

  /// Set Cover Image Function
  Future<void> setUserCoverImageFunction(String imageId) async {
    isLoading(true);
    String url = ApiUrl.setCoverImageApi;
    log('setUserCoverImageFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['image_id'] = imageId;

      log('setUserCoverImageFunction Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value1) async {
        log('setUserCoverImageFunction value1 : $value1');

        SavedDataModel savedDataModel =
            SavedDataModel.fromJson(json.decode(value1));
        successStatus.value = savedDataModel.statusCode;

        if (successStatus.value == 200) {
          Fluttertoast.showToast(msg: savedDataModel.msg);
          await getUserDetailsFunction();
        } else {
          log('setUserCoverImageFunction Else');
        }
      });
    } catch (e) {
      log('setUserCoverImageFunction Error :$e');
      rethrow;
    }
    Get.back();
    isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    await getUserDetailsFunction();
  }

  /// Set Value in local variables to use change values
  void getAndSetExerciseValue() {
    exerciseValue = userDetails!.basic.exercise == "no"
        ? MoreAboutMe.no
        : userDetails!.basic.exercise == "yes"
            ? MoreAboutMe.yes
            : userDetails!.basic.exercise == "sometimes"
                ? MoreAboutMe.sometimes
                : MoreAboutMe.hidden;
  }

  void getAndSetDrinkingValue() {
    drinkingValue = userDetails!.basic.drinking == "no"
        ? MoreAboutMe.no
        : userDetails!.basic.drinking == "yes"
            ? MoreAboutMe.yes
            : userDetails!.basic.drinking == "socially"
                ? MoreAboutMe.sometimes
                : MoreAboutMe.hidden;
  }

  void getAndSetSmokingValue() {
    smokingValue = userDetails!.basic.smoking == "no"
        ? MoreAboutMe.no
        : userDetails!.basic.smoking == "yes"
            ? MoreAboutMe.yes
            : userDetails!.basic.smoking == "socially"
                ? MoreAboutMe.sometimes
                : MoreAboutMe.hidden;
  }

  void getAndSetKidsValue() {
    kidsValue = userDetails!.basic.kids == "no"
        ? MoreAboutMe.no
        : userDetails!.basic.kids == "yes"
            ? MoreAboutMe.yes
            : userDetails!.basic.kids == "someday"
                ? MoreAboutMe.sometimes
                : MoreAboutMe.hidden;
  }

  Future<void> setUserImagesInPrefs() async {
    List<String> tempList = [];

    for (var value in captureImageList) {
      Map<String, dynamic> singleData = {
        "id": value.id,
        "image": value.imageUrl,
        "isImageFromNetwork": value.isImageFromNetwork
      };

      /// Convert single data in json format & store in list string format
      tempList.add(jsonEncode(singleData).toString());
    }
    await userPreference.setListOfStringInPrefs(value: tempList);
    log('tempList : $tempList');
    /*for(var value in tempList) {
      UploadUserImage uploadUserImage = UploadUserImage.fromJson(json.decode(value));
    }*/
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }

  Future<void> getPoliticsValueFromPrefs() async {
    politics = await userPreference.getStringFromPrefs(
        key: UserPreference.politicsKey);
    loadUI();
  }

  Future<void> getReligionValueFromPrefs() async {
    religion = await userPreference.getStringFromPrefs(
        key: UserPreference.religionKey);
    loadUI();
  }

  Future<void> getStarSignValueFromPrefs() async {
    starSign = await userPreference.getStringFromPrefs(
        key: UserPreference.starSignKey);
    loadUI();
  }

  Future<void> getMyBasicGenderValueFromPrefs() async {
    gender = await userPreference.getStringFromPrefs(
        key: UserPreference.myBasicGenderValueKey);
    loadUI();
  }

  Future<void> getMyBasicWorkValueFromPrefs() async {
    work = await userPreference.getStringFromPrefs(
        key: UserPreference.myBasicWorkValueKey);
    loadUI();
  }

  Future<void> getMyBasicEducationValueFromPrefs() async {
    education = await userPreference.getStringFromPrefs(
        key: UserPreference.myBasicEducationValueKey);
    loadUI();
  }

  Future<void> getMyBasicHomeTownValueFromPrefs() async {
    homeTown = await userPreference.getStringFromPrefs(
        key: UserPreference.myBasicHomeTownValueKey);
    loadUI();
  }

  Future<void> getMyBasicLookingForValueFromPrefs() async {
    lookingFor = await userPreference.getStringFromPrefs(
        key: UserPreference.myBasicLookingForValueKey);
    loadUI();
  }
}
