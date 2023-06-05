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

  List<Msg> genderList = [];
  List<Msg> mainGenderList = [];
  List<Msg> nonBinaryGenderList = [];
  Msg selectedGenderValue = Msg(id: "1", name: "Female");
  UserPreference userPreference = UserPreference();

  SignUpPreference signUpPreference = SignUpPreference();

  Future<void> geGenderFunction() async {
    isLoading(true);

    String url = ApiUrl.getGenderApi;
    log("geGenderFunction get url: $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      GenderModel getTargetGenderModel =
          GenderModel.fromJson(json.decode(response.body));

      // isSuccessStatus =response.statusCode ;

      if (response.statusCode == 200) {
        // log("response.statusCode: ${response.statusCode}");
        // log("response.body: ${response.body}");
        genderList = getTargetGenderModel.msg;
        genderList.isNotEmpty ? selectedGenderValue = genderList[0] : null;
        for (var element in genderList) {
          if (element.name == "Woman" ||
              element.name == "Man" ||
              element.name == "Non-Binary") {
            mainGenderList.add(element);
          } else {
            nonBinaryGenderList.add(element);
          }
        }

        log('mainGenderList :${mainGenderList.length}');
        log('nonBinaryGenderList :${nonBinaryGenderList.length}');

        log("selectedGenderValue: $selectedGenderValue");

        log("selectedGenderValue: $selectedGenderValue");
      } else {
        log("geGenderFunction Error");
      }
    } catch (e) {
      log("geGenderFunction Error $e");
      rethrow;
    }
    /*finally {
      isLoading(false);
    }*/
    isLoading(false);
  }

  void radioButtonOnChangeFunction(Msg selectedValue) {
    isLoading(true);
    selectedGenderValue = selectedValue;
    isLoading(false);
  }

  Future<void> nextButtonFunction() async {
    await signUpPreference.setStringValueInPrefs(
      key: SignUpPreference.targetGenderKey,
      value: selectedGenderValue.id,
    );
    await userPreference.setStringValueInPrefs(
        key: UserPreference.isShowMeGenderKey, value: selectedGenderValue.name);
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
