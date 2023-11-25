import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:dater/controller/home_screen_controller.dart';
import 'package:dater/model/home_screen_model/suggestions_model.dart';
import 'package:dater/model/saved_data_model/saved_data_model.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../common_modules/custom_button.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/font_family.dart';
import '../model/favorite_screen_model/liker_model.dart';
import '../utils/preferences/user_preference.dart';
import '../utils/style.dart';

class FavoriteScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt successStatus = 0.obs;
  RxBool isShowAgain = false.obs;
  UserPreference userPreference = UserPreference();

  LikesDialogShowAgain likesDialogShowAgain = LikesDialogShowAgain.yes;
  String lastLikeProfileId = "";

  List<LikerData> likerList = <LikerData>[].obs;
  RxBool selectedLike = false.obs;
  RxBool selectedLiked = false.obs;

  var dioRequest = dio.Dio();

  backWithLike(int index) async {
    // homeScreenCont.interestList
    // SuggestionData likedMe = SuggestionData(id: likerList[index].id,
    // name: likerList[index].name,
    //   distance: likerList[index].distance,
    //   activeTime: likerList[index].activeTime,
    //   age: likerList[index].age,
    //     // images: likerList[index].images,
    //   verified: likerList[index].verified,
    //
    // );
    Get.back();
    await getLikerDetailsFunction(likerList[index].id);
    // Get.back();
    // Get.find<IndexScreenController>().changeIndex(1);
    // Get.to(() => HomeScreen())?.then((value) async {
    //   await getYourLikerFunction();
    // });
  }

  removeBlur(int likerDataIndex) async {
    isLoading(true);
    String url = ApiUrl.unBlurImgApi;
    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        'liker_id': likerList[likerDataIndex].id,
      });
      var response = await dioRequest.post(url, data: formData);
      SavedDataModel savedDataModel =
          SavedDataModel.fromJson(json.decode(response.data));
      successStatus.value = savedDataModel.statusCode;
      if (successStatus.value == 200) {
        likerList[likerDataIndex].visible = true;
      } else {
        Fluttertoast.showToast(msg: savedDataModel.msg);
      }
    } catch (e) {
      log('$e');
    }
    isLoading(false);
    loadUI();
  }

  Future<void> getLikerDetailsFunction(String likerId) async {
    HomeScreenController homeScreenCont = Get.find<HomeScreenController>();
    homeScreenCont.isLoading(true);
    String url = ApiUrl.getUserDetailsApi;
    log('getLikerDetailsFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['user_id'] = likerId;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log("value :$value");
        SuggestionListModel userDetailsModel =
            SuggestionListModel.fromJson(json.decode(value));

        if (userDetailsModel.statusCode == 200) {
          int insertAt = 0;
          if (homeScreenCont.currentUserIndex.value > 0) {
            insertAt = homeScreenCont.cardController.value.currentIndex ;
          }
          if (userDetailsModel.msg.isNotEmpty) {
            // if (homeScreenCont.suggestionList.isEmpty) {
            //   homeScreenCont.suggestionList
            //       .insert(0, userDetailsModel.msg.first);
            //   // homeScreenCont.currentUserIndex.value = 0;
            //   // log(name: 'length when changed', '${homeScreenCont.suggestionList.length}');
            // } else {
            homeScreenCont.suggestionList
                .insert(insertAt, userDetailsModel.msg.first);
            // }
          }
        } else {
          log('getLikerDetailsFunction Else');
        }
      });
    } catch (e) {
      log('getLikerDetailsFunction Error :$e');
      rethrow;
    }
    homeScreenCont.isLoading(false);
  }

  // Get Your Liker Function
  Future<void> getYourLikerFunction() async {
    isLoading(true);
    String url = ApiUrl.getLikerApi;
    log('getYourLikerFunction Api Url : $url');
    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var formData = dio.FormData.fromMap({'token': verifyToken});

      var response = await dioRequest.post(url, data: formData);
      log(name: 'Suggestion Response:', '${response.data}');

      LikerModel likerModel = LikerModel.fromJson(json.decode(response.data));
      successStatus.value = likerModel.statusCode;

      if (successStatus.value == 200) {
        likerList.clear();
        likerList.addAll(likerModel.msg);
      } else {
        log('getYourLikerFunction Else');
      }

      /*var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('Liker Data : $value');

        LikerModel likerModel = LikerModel.fromJson(json.decode(value));
        likerList.clear();
        likerList.addAll(likerModel.msg);
        log('likerList Length : ${likerList.length}');
      });*/
    } catch (e) {
      log('getYourLikerFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  Future<void> understandlikeFunction() async {
    await userPreference.setBoolValueInPrefs(
        key: UserPreference.isLikeInKey, value: selectedLiked.value);
    log("selectedLiked.value: ${selectedLiked.value}");
    await getYourLikerFunction();

    // Get.offAll(()=> IndexScreen());
    // await getUserSuggestionsFunction();
    // await initMethod();
  }

  // Alert Dialog
  showLikesDialog(BuildContext context) async {
    // if (selectedLike.value == false) {
    log("selectedLike.value2222 ${selectedLike.value}");

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 50,
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "See who likes you",
                    style: TextStyleConfig.textStyle(
                      fontSize: 20,
                      fontFamily: FontFamilyText.sFProDisplayBold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Every regather will cost you 1 coin",
                    style: TextStyleConfig.textStyle(
                      fontSize: 14.sp,
                      fontFamily: FontFamilyText.sFProDisplayRegular,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ButtonCustom(
                    text: "Understand",
                    onPressed: () async {
                      log("11");
                      Get.back();
                      await understandlikeFunction();

                      log("22");
                    },
                    fontWeight: FontWeight.bold,
                    textsize: 14.sp,
                    textFontFamily: FontFamilyText.sFProDisplayHeavy,
                    textColor: AppColors.whiteColor2,
                    backgroundColor: AppColors.darkOrangeColor,
                  ).commonSymmetricPadding(horizontal: 35),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: AppColors.lightOrangeColor,
                        hoverColor: AppColors.lightOrangeColor,
                        activeColor: AppColors.lightOrangeColor,
                        tristate: false,
                        side: const BorderSide(
                          width: 2,
                          color: AppColors.blackColor,
                        ),
                        shape: const CircleBorder(),
                        value: selectedLike.value,
                        onChanged: (value) {
                          setState(() {
                            selectedLike.value = !selectedLike.value;
                          });
                        },
                      ),
                      Text(
                        "don't show again",
                        style: TextStyleConfig.textStyle(
                          fontSize: 14.sp,
                          fontFamily: FontFamilyText.sFProDisplayRegular,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    log('iniiit favourite controller');
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    selectedLike.value =
        await userPreference.getBoolFromPrefs(key: UserPreference.isLikeInKey);

    if (selectedLike.value != true) {
      showLikesDialog(Get.context!);
    } else {
      await getYourLikerFunction();
    }
    // isShowAgain.value = await userPreference.getStringFromPrefs(key: UserPreference.isSeeWhoLikesYouKey);
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
