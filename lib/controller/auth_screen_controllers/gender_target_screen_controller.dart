// import 'dart:convert';
// import 'dart:developer';
// import 'package:dater/model/authantication_model/gender_target_screen_model/get_gender_target_model.dart';
// import 'package:http/http.dart' as http;

// import 'package:dater/constants/api_url.dart';
// import 'package:get/get.dart';

// class GenderTargetScreenController extends GetxController {
//   RxString selectedvalue = "Female".obs;
//   RxBool isLoading = false.obs;
//   RxBool isSuccessStatus = false.obs;
//   List<GetTargetGenderModel> msgData = [];

//   Future<void> getargetGenderFunction() async {
//     isLoading(true);

//     String url = ApiUrl.getGenderApi;
//     log("getargetGenderFunction get url: $url");

//     try {
//       http.Response response = await http.get(Uri.parse(url));

//       GetTargetGenderModel getTargetGenderModel =
//           GetTargetGenderModel.fromJson(json.decode(response.body));

//       // isSuccessStatus =response.statusCode ;

//       if (response.statusCode == 200) {
//         log("response.statusCode: ${response.statusCode}");
//         log("response.body: ${response.body}");
//         msgData = getTargetGenderModel.msg;

//         log("msgData: $msgData");
//       } else {
//         log("getargetGenderFunction Error");
//       }
//     } catch (e) {
//       log("getargetGenderFunction Error $e");
//       rethrow;
//     } finally {
//       isLoading(false);
//     }
//   }

//   @override
//   void onInit() {
//     getargetGenderFunction();
//     super.onInit();
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/authentication_model/gender_select_screen_model/get_gender_model.dart';
import '../../screens/authentication_screen/goal_select_screen/goal_select_screen.dart';
import '../../utils/preferences/signup_preference.dart';
import '../../utils/preferences/user_preference.dart';

class GenderTargetScreenController extends GetxController {
  // RxString selectedvalue = "Female".obs;
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  String showMeGender = "";

  List<Msg> targetGenderList = [];
  Msg targetGenderSelectedValue = Msg(id: "1", name: "Female");
  UserPreference userPreference = UserPreference();

  SignUpPreference signUpPreference = SignUpPreference();

  Future<void> geGenderFunction() async {
    isLoading(true);

    String url = ApiUrl.getTargetGenderApi;
    log("geGenderFunction get url: $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      GenderModel getTargetGenderModel =
          GenderModel.fromJson(json.decode(response.body));

      // isSuccessStatus =response.statusCode ;

      if (response.statusCode == 200) {
        log("response.statusCode: ${response.statusCode}");
        log("response.body: ${response.body}");
        targetGenderList = getTargetGenderModel.msg;
        targetGenderList.isNotEmpty
            ? targetGenderSelectedValue = targetGenderList[0]
            : null;

        // log("msgData: $msgData");
      } else {
        log("geGenderFunction Error");
      }
    } catch (e) {
      log("geGenderFunction Error $e");
      rethrow;
    } /*finally {
      isLoading(false);
    }*/
    isLoading(false);
  }

  void radioButtonOnChangeFunction(Msg selectedValue) {
    isLoading(true);
    targetGenderSelectedValue = selectedValue;
    isLoading(false);
  }

  Future<void> nextButtonFunction() async {
    await signUpPreference.setStringValueInPrefs(
      key: SignUpPreference.targetGenderKey,
      value: targetGenderSelectedValue.id,
    );
    await userPreference.setStringValueInPrefs(key: UserPreference.isShowMeGenderKey, value: targetGenderSelectedValue.name);
    Get.to(() => GoalSelectScreen());
  }

  Future<void> gettargetgenderValueFromPrefs() async {
    showMeGender = await userPreference.getStringFromPrefs(
        key: SignUpPreference.isShowMeGenderKey);
    log("showMeGender $showMeGender");
    await geGenderFunction();
    // isLoading(true);
    // isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    await gettargetgenderValueFromPrefs();
  }
}
