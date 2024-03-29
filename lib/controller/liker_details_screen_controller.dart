import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swipable_stack/swipable_stack.dart';

import '../constants/api_url.dart';
import '../constants/app_images.dart';
import '../constants/enums.dart';

// import '../model/favorite_screen_model/liker_model.dart';
// import '../model/home_screen_model/matches_model.dart';
import '../model/home_screen_model/super_love_model.dart';
import '../model/liker_details_screen_model/liker_user_details_model.dart';
import '../model/profile_screen_models/basic_model.dart';
import '../screens/home_screen/widgets/match_dialog.dart';
import '../utils/functions.dart';
import '../utils/preferences/user_preference.dart';

class LikerDetailsScreenController extends GetxController {
  String likerId = Get.arguments[0];
  RxBool isLoading = false.obs;
  RxBool isVisible = true.obs;

  double physicalDeviceWidth = 0.0;
  double physicalDeviceHeight = 0.0;

  RxBool selectedSuperLove = false.obs;

  RxString gender = ''.obs;
  RxString height = ''.obs;
  RxString exercise = ''.obs;
  RxString smoking = ''.obs;
  RxString drinking = ''.obs;
  RxString politics = ''.obs;
  RxString religion = ''.obs;
  RxString kids = ''.obs;

  SwipableStackController cardController = SwipableStackController();
  UserPreference userPreference = UserPreference();

  // MatchPersonData singlePersonData = MatchPersonData();
  UserDetails userDetails = UserDetails();
  RxBool selected = false.obs;

  Future<void> understandSuperLoveFunction(int index) async {
    await userPreference.setBoolValueInPrefs(
        key: UserPreference.isSuperLoveInKey, value: selectedSuperLove.value);
    // log("selectedSuperLove.value: ${selectedSuperLove.value}");

    await superLoveProfileFunction(
      likedId: "${userDetails.id}",
      likeType: LikeType.super_love,
      // swipeCard: false,
      // index: index
    );
  }

  /// Like & SuperLove function
  Future<void> superLoveProfileFunction(
      {required String likedId, required LikeType likeType}) async {
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
        if (likeType == LikeType.like) {
          cardController.next(
            swipeDirection: SwipeDirection.right,
          );
        } else if (likeType == LikeType.super_love) {
          cardController.next(
            swipeDirection: SwipeDirection.up,
            duration: const Duration(milliseconds: 600),
          );
        }
        printAll('done: ${superLoveModel.isMatch.toString()}');
      } else if (superLoveModel.statusCode == 400) {
        Fluttertoast.showToast(msg: superLoveModel.msg);
        if (superLoveModel.msg.toLowerCase() ==
            "You already liked this account") {
          if (likeType == LikeType.like) {
            cardController.next(
              swipeDirection: SwipeDirection.right,
            );
          } else if (likeType == LikeType.super_love) {
            cardController.next(
              swipeDirection: SwipeDirection.up,
              duration: const Duration(milliseconds: 600),
            );
          }
        }
        Get.back();
      } else {
        log('superLoveProfileFunction Else');
      }
    } catch (e) {
      log('superLoveProfileFunction Error : $e');
      rethrow;
    }
  }



  List<BasicModel> setBasicListFunction() {
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
        .add(BasicModel(image: AppImages.refreshImage, name: religion.value));
    basicList.add(BasicModel(image: AppImages.kidsImage, name: kids.value));

    return basicList;
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    var physicalScreenSize = window.physicalSize;
    physicalDeviceWidth = physicalScreenSize.width;
    physicalDeviceHeight = physicalScreenSize.height;
    log('physicalDeviceHeight : $physicalDeviceHeight');
    log('physicalDeviceWidth : $physicalDeviceWidth');
    // await getLikerDetailsFunction();
  }
}
