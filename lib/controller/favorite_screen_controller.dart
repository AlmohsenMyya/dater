import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:dater/utils/extensions.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  removeBlur(int likerDataIndex) {
    likerList[likerDataIndex].blurred = false;
    //TODO add api to remove blur
    loadUI();
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
      log('Suggestion Response : ${response.data}');

      LikerModel likerModel = LikerModel.fromJson(json.decode(response.data));
      successStatus.value = likerModel.statusCode;

      if (successStatus.value == 200) {
        likerList.clear();
        likerList.addAll(likerModel.msg);
        log('likerList Length : ${likerList.length}');
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
                    text: "Undestand",
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
