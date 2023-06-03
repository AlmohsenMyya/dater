import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dater/constants/api_url.dart';
import 'package:dater/constants/app_images.dart';
import 'package:dater/controller/profile_screen_controller.dart';
import 'package:dater/model/home_screen_model/super_love_model.dart';
import 'package:dater/model/profile_screen_models/basic_model.dart';
import 'package:dater/model/profile_screen_models/report_model.dart';
import 'package:dater/screens/location_permission_screen/location_permission_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../constants/enums.dart';
import '../model/home_screen_model/regather_model.dart';
import '../model/home_screen_model/suggestions_model.dart';
import '../model/profile_screen_models/language_save_model.dart';
import '../model/saved_data_model/saved_data_model.dart';
import '../screens/home_screen/widgets/match_dialog.dart';
import '../utils/functions.dart';
import '../utils/preferences/user_preference.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isVisible = true.obs;
  RxInt successStatus = 0.obs;
  SwipableStackController cardController = SwipableStackController();

  double physicalDeviceWidth = 0.0;
  double physicalDeviceHeight = 0.0;

  String lastLikeProfileId = "";

  Location location = Location();
  late LocationData locationData;

  var dioRequest = dio.Dio();

  // RxString selectedval = ''.obs;
  RxBool selected = false.obs;
  RxBool selectedSuperLove = false.obs;

  // int superLoveIndex = 0;
  var scrollController = ScrollController();
  String selectedVal = "";
  RxString name = ''.obs;
  RxString currentUserId = ''.obs;
  RxString bio = ''.obs;
  RxString age = ''.obs;
  RxString profilePrompts = ''.obs;
  RxString selectedVlu = ''.obs;
  RxString gender = ''.obs;
  RxString work = ''.obs;
  RxString education = ''.obs;
  RxString height = ''.obs;
  RxString exercise = ''.obs;
  RxString smoking = ''.obs;
  RxString drinking = ''.obs;
  RxString politics = ''.obs;
  RxString religion = ''.obs;
  RxString kids = ''.obs;
  RxString distance = "".obs;
  RxString homeTown = "".obs;
  RxString verifiedUser = "".obs;

  List<SuggestionData> suggestionList = [];
  SuggestionData singlePersonData = SuggestionData();
  UserPreference userPreference = UserPreference();
  List<BasicModel> basicList = [];
  List<Interest> interestList = [];
  List<String> languageList = [];
  List<UserImage> userImageList = [];
  RxInt currentUserIndex = 0.obs;

  bool isRewindAllow = false;

  RxBool isCancelButtonClick = false.obs;
  RxBool isStarButtonClick = false.obs;
  RxBool isLikeButtonClick = false.obs;

  List<String> images = [
    AppImages.swiper1Image,
    AppImages.swiper2Image,
    AppImages.swiper1Image,
    AppImages.swiper2Image,
  ];

  List<ReportModel> reportsList = [];
  RxInt selectedReportIndex = 0.obs;

  hideSuperLoveButtonFunction(SwipeDirectionEnum swipeDirectionEnum) {
    if (swipeDirectionEnum == SwipeDirectionEnum.left ||
        swipeDirectionEnum == SwipeDirectionEnum.right) {
      isVisible.value = false;
    } else {
      isVisible.value = true;
    }
  }

  fetchMobileLocation() async {
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      log("111");
      Get.to(() => LocationPermissionScreen());

      if (!serviceEnabled) {
        return;
      }
    }
    // locationData = await location.getLocation();
  }

  Future<void> getLocation() async {
    log("getLocation");
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // ignore: void_checks
        // isLoading(true);
        fetchMobileLocation();
        // isLoading(false);
      },
    );
  }

// GetUndestandfunction,
  Future<void> understandFunction() async {
    await userPreference.setBoolValueInPrefs(
        key: UserPreference.isragatherInKey, value: selected.value);
    log("selected.value: ${selected.value}");
    await regatherFunction();
    // Get.offAll(()=> IndexScreen());
    // await getUserSuggestionsFunction();
    // await initMethod();
  }

  Future<void> understandSuperLoveFunction(int index) async {
    await userPreference.setBoolValueInPrefs(
        key: UserPreference.isSuperLoveInKey, value: selectedSuperLove.value);
    log("selectedSuperLove.value: ${selectedSuperLove.value}");

    await superLoveProfileFunction(
        likedId: "${singlePersonData.id}",
        likeType: LikeType.super_love,
        swipeCard: false,
        index: index);
  }

  Future<void> getListReports() async {
    isLoading(true);
    String url = ApiUrl.getReportsTypesApi;
    try {
      var response = await dioRequest.get(url);

      ReportsModelMsg reportsModelMsg =
          ReportsModelMsg.fromJson(json.decode(response.data));
      successStatus.value = reportsModelMsg.statusCode;
      if (successStatus.value == 200) {
        reportsList.clear();
        if (reportsModelMsg.msg.isNotEmpty) {
          reportsList.addAll(reportsModelMsg.msg);
          log('reportsList : ${reportsList.length}');
        }
      } else {
        log('getListReportsError Else');
      }
    } catch (e) {
      log('getListReports Error :$e');

      rethrow;
    }

    isLoading(false);
  }

  Future<void> reportUser(
      {required String profileId, required String reportReasonId}) async {
    String url = ApiUrl.reportUser;

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);

      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        "profile_id": profileId,
        "report_reason_id": reportReasonId
      });

      printAll(name: 'reported', '$profileId $reportReasonId');
      var response = await dioRequest.post(url, data: formData);

      LanguageSaveModel reportResponse =
          LanguageSaveModel.fromJson(json.decode(response.data));
      successStatus.value = reportResponse.statusCode;
      // if (successStatus.value == 200) {
      // } else {
      //   log('reportAccountFunction Else');
      // }
      Fluttertoast.showToast(msg: reportResponse.msg);
      cardController.next(
        swipeDirection: SwipeDirection.left,
      );
    } catch (e) {
      log('reportAccountFunction Error :$e');

      rethrow;
    }
    Get.back();
    isLoading(false);
  }

  /// Get Suggestions Function
  Future<void> getUserSuggestionsFunction() async {
    isLoading(true);
    String url = ApiUrl.getSuggestionApi;
    log('Suggestion Api Url :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      // log('Get User Suggestion User Token : $verifyToken');

      var formData = dio.FormData.fromMap({'token': verifyToken});

      var response = await dioRequest.post(url, data: formData);
      log('Suggestion Response : ${response.data}');

      // printAll(name: 'suggest',"${response.data}");
      SuggestionListModel suggestionListModel =
          SuggestionListModel.fromJson(json.decode(response.data));
      successStatus.value = suggestionListModel.statusCode;

      if (successStatus.value == 200) {
        suggestionList.clear();
        // suggestionList = [];

        if (suggestionListModel.msg.isNotEmpty) {
          suggestionList.addAll(suggestionListModel.msg);

          log('suggestionList1212 : ${suggestionList.length}');
        }
      } else {
        log('getUserSuggestionsFunction Else');
      }

      /*var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers['Content-Type'] = "multipart/form-data";
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((value) async {
        log("Suggestion Api value :$value");
        SuggestionListModel suggestionListModel = SuggestionListModel.fromJson(json.decode(value));
        successStatus.value = suggestionListModel.statusCode;
        if (successStatus.value == 200) {
          suggestionList.clear();
          // suggestionList = [];

          if (suggestionListModel.msg.isNotEmpty) {
            suggestionList.addAll(suggestionListModel.msg);
            // singlePersonData = suggestionList[0];
            // setChangedUserData(0);

            // log("singlePersonData :${singlePersonData.name}");
            // log("singlePersonData :${singlePersonData.bio}");

            log('suggestionList1212 : ${suggestionList.length}');
          }
        } else {
          log('getUserSuggestionsFunction Else');

        }
      });*/
    } catch (e) {
      log('getMatchesFunction Error :$e');

      rethrow;
    }

    isLoading(false);
    // loadUI();
    // await getUserSuggestionsFunction2();
  }

  /// Set Basic Details
  List<BasicModel> setBasicListFunction({required SuggestionData singleItem}) {
    List<BasicModel> basicList = [];
    // basicList.add(BasicModel(image: AppImages.workImage, name: work.value));
    // basicList.add(
    //     BasicModel(image: AppImages.educationImage, name: education.value));

    basicList.add(BasicModel(image: AppImages.genderImage, name: gender.value));
    basicList.add(
        BasicModel(image: AppImages.heightImage, name: "${height.value} cm"));
    basicList
        .add(BasicModel(image: AppImages.exerciseImage, name: exercise.value));
    basicList
        .add(BasicModel(image: AppImages.smokingImage, name: smoking.value));

    basicList
        .add(BasicModel(image: AppImages.drinkingImage, name: drinking.value));
    basicList
        .add(BasicModel(image: AppImages.politicsImage, name: politics.value));
    basicList
        .add(BasicModel(image: AppImages.religionImage, name: religion.value));

    basicList.add(BasicModel(image: AppImages.kidsImage, name: kids.value));

    return basicList;
  }

  /*/// Like   function
  Future<void> likeProfileFunction(
      {required String likedId, required LikeType likeType}) async {
    isLoading(true);
    String url = ApiUrl.likeProfileApi;

    try {
      Map<String, dynamic> bodyData = {
        "token": verifyToken,
        "type": likeType.name,
        "liked_id": likedId
      };

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );

      log('Like Profile Response Function : ${response.body}');

      LikeProfileModel likeProfileModel =
          LikeProfileModel.fromJson(json.decode(response.body));

      if (likeProfileModel.statusCode == 200) {
        /// Card Swipe right
        cardController.next(
          swipeDirection: SwipeDirection.right,
        );
      } else {
        log('likeProfileFunction Else');
      }
    } catch (e) {
      log('likeProfileFunction Error : $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }*/

  /// Like & SuperLove function
  Future<void> superLoveProfileFunction({
    required String likedId,
    required LikeType likeType,
    swipeCard = false,
    required int index,
  }) async {
    String url = ApiUrl.superLoveProfileApi;

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      Map<String, dynamic> bodyData = {
        "token": verifyToken,
        "type": likeType.name,
        "liked_id": likedId
      };
      log('bodyData : $bodyData');

      http.Response response = await http.post(
        Uri.parse(url),
        body: bodyData,
      );

      log('superLove ProfileFunction Response Function : ${response.body}');

      SuperLoveModel superLoveModel =
          SuperLoveModel.fromJson(json.decode(response.body));

      if (superLoveModel.statusCode == 200) {
        if (superLoveModel.isMatch) {
          Get.dialog(
            MatchDialog(
              tName: name.value,
              tWork: work.value,
              tDistance: distance.value,
              name: profileCont.userName.value,
              work: profileCont.userWork.value,
              tImage: userImageList[0].imageUrl,
              image: profileCont.userImages[0].imageUrl,
            ),
          );
        }
        // Fluttertoast.showToast(msg: superLoveModel.msg);
        /// If Coming from card swipe that time not call this if condition because double time swipe the card
        /*if (swipeCard == false) {
          if (likeType == LikeType.like) {
            log('Log Type 200 -1 : $likeType');
            cardController.next(
              swipeDirection: SwipeDirection.right,
            );
          } else if (likeType == LikeType.super_love) {
            log('Log Type 200 -2 : $likeType');
            cardController.next(
              swipeDirection: SwipeDirection.up,
              duration: const Duration(milliseconds: 600),
            );
          }
        }*/

        /// Remove Data at 0 Index & set new data in variable
        // suggestionList.removeAt(0);
        // When swipe index & suggestion list length same that time clear the suggestion list
        if (index == suggestionList.length) {
          suggestionList = [];
        }
        if (suggestionList != []) {
          /// When Swipe complete that time set new user data in display variable
          // singlePersonData = suggestionList[0];
          setChangedUserData(index);
        } else {
          suggestionList.clear();
          suggestionList = [];
        }

        // loadUI();
      } else if (superLoveModel.statusCode == 400) {
        Fluttertoast.showToast(msg: superLoveModel.msg);
        if (superLoveModel.msg.toLowerCase() ==
            "You already liked this account".toLowerCase()) {
          log('Log Type 400 -1 : $likeType');

          /// If Coming from card swipe that time not call this if condition because double time swipe the card
          /*if (swipeCard == false) {
            if (likeType == LikeType.like) {
              cardController.next(
                swipeDirection: SwipeDirection.right,
              );
            } else if (likeType == LikeType.super_love) {
              log('Log Type 400 -2 : $likeType');
              cardController.next(
                swipeDirection: SwipeDirection.up,
                duration: const Duration(milliseconds: 600),
              );
            }
          }*/

          /// Remove Data at 0 Index & set new data in variable
          // suggestionList.removeAt(0);
          if (index == suggestionList.length) {
            suggestionList = [];
          }
          if (suggestionList.isNotEmpty) {
            /// When Swipe complete that time set new user data in display variable
            // singlePersonData = suggestionList[0];
            setChangedUserData(index);
          } else {
            suggestionList.clear();
            suggestionList = [];
          }
        }
      } else {
        log('superLoveProfileFunction Else');
      }
    } catch (e) {
      log('superLoveProfileFunction Error : $e');
      rethrow;
    }
    loadUI();
  }

  /// Regather Function
  Future<void> regatherFunction() async {
    // isLoading(true);
    String url = ApiUrl.superLoveProfileApi;
    log('Regather Api Url :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var formData = dio.FormData.fromMap({
        'token': verifyToken,
        'type': LikeType.regather.name,
        'liked_id': lastLikeProfileId
      });

      var response = await dioRequest.post(url, data: formData);
      log('regather Response : ${response.data}');

      RegatherModel regatherModel =
          RegatherModel.fromJson(json.decode(response.data));
      successStatus.value = regatherModel.statusCode;

      if (successStatus.value == 200) {
        // Fluttertoast.cancel();
        // Fluttertoast.showToast(msg: regatherModel.msg);

        // cardController.rewind();
        // log('cardController.canRewind : ${cardController.canRewind}');
      } else {
        if (regatherModel.msg.toLowerCase() ==
            "You already regathered on this account".toLowerCase()) {
          Fluttertoast.showToast(msg: "You already regathered on your account");
        }

        log('regatherFunction Else');
      }
    } catch (e) {
      log('regatherFunction Error :$e');
      rethrow;
    }

    loadUI();
    // isLoading(false);
  }

  /// When swipe complete that time user data change
  setChangedUserData(int index) {
    name = suggestionList[index].name.toString().obs;
    currentUserId = suggestionList[index].id!.obs;
    bio = suggestionList[index].bio.toString().obs;
    age = suggestionList[index].age.toString().obs;
    // profilePrompts = suggestionList[index].profilePrompts.toString().obs;
    work = suggestionList[index].basic!.work.obs;
    gender = suggestionList[index].basic!.gender.obs;
    education = suggestionList[index].basic!.education.obs;
    height = suggestionList[index].basic!.height.obs;
    exercise = suggestionList[index].basic!.exercise.obs;
    smoking = suggestionList[index].basic!.smoking.obs;
    drinking = suggestionList[index].basic!.drinking.obs;
    politics = suggestionList[index].basic!.politics.obs;
    religion = suggestionList[index].basic!.religion.obs;
    kids = suggestionList[index].basic!.kids.obs;
    distance = suggestionList[index].distance!.obs;
    homeTown = suggestionList[index].homeTown!.obs;
    verifiedUser = suggestionList[index].verified!.obs;

    basicList.clear();
    // setBasicListFunction(singleItem: suggestionList[index]);
    interestList.clear();
    if (suggestionList[index].interest != []) {
      for (int i = 0; i < suggestionList[index].interest!.length; i++) {
        interestList.add(suggestionList[index].interest![i]);
      }
    }
    log('interestList Length : ${interestList.length}');
    languageList.clear();
    if (suggestionList[index].languages != []) {
      languageList.addAll(suggestionList[index].languages!);
    }

    userImageList.clear();
    if (suggestionList[index].images != []) {
      userImageList.addAll(suggestionList[index].images!);
    }

    log("suggestionList : ${suggestionList.length}");
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  late ProfileScreenController profileCont;

  initMethod() async {
    //Size in physical pixels
    profileCont = Get.put(ProfileScreenController());

    var physicalScreenSize = window.physicalSize;
    physicalDeviceWidth = physicalScreenSize.width;
    physicalDeviceHeight = physicalScreenSize.height;
    log('physicalDeviceHeight : $physicalDeviceHeight');
    log('physicalDeviceWidth : $physicalDeviceWidth');
    selected.value = await userPreference.getBoolFromPrefs(
        key: UserPreference.isragatherInKey);

    await getLocation();
    await updateUserLocationFunction();
    await getUserSuggestionsFunction();
    await getListReports();

    // await getUserSuggestionsFunction();
    // await setBasicListFunction();

    // scrollController.addListener((){
    //   if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
    //     if(isVisible.value == true) {
    //       isVisible.value = false;
    //       print("**** ${isVisible.value} up"); //Move IO away from setState
    //      loadUI();
    //     }
    //   } else {
    //     if(scrollController.position.userScrollDirection == ScrollDirection.forward){
    //       if(isVisible.value == false) {
    //         isVisible.value = true;
    //         print("**** ${isVisible.value} down"); //Move IO away from setState
    //         loadUI();
    //       }
    //     }
    //   }});

    /*if (scrollController.position.atEdge) {
      if (scrollController.position.pixels < 0) {
        log('scrollController.position.pixels :${scrollController.position.pixels}');
        if (isVisible.value) {
          isLoading(true);
          isVisible.value = false;
          isLoading(false);
        }
        loadUI();
      }
    } else {
      if (!isVisible.value) {
        isVisible.value = true;
      }
      loadUI();
    }*/
    // loadUI();
  }

  Future<void> updateUserLocationFunction() async {
    isLoading(true);
    String url = ApiUrl.updateUserLocationApi;
    log('Update User location Api Url : $url');

    try {
      locationData = await location.getLocation();
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['lat'] = "${locationData.latitude}";
      request.fields['long'] = "${locationData.longitude}";

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('Location Update value : $value');
        SavedDataModel savedDataModel =
            SavedDataModel.fromJson(json.decode(value));
        successStatus.value = savedDataModel.statusCode;

        if (successStatus.value == 200) {
          log('Message :${savedDataModel.msg}');
        } else {
          log('updateUserLocationFunction Else');
        }
      });
    } catch (e) {
      log('updateUserLocationFunction Error :$e');
    }
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
