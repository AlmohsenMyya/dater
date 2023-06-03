import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:dater/screens/settings_screen/settings_screen.dart';
import 'package:dater/utils/functions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/authentication_model/gender_select_screen_model/get_gender_model.dart';
import '../../screens/authentication_screen/gender_target_screen/gender_target_screen.dart';
import '../../utils/preferences/signup_preference.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../utils/preferences/user_preference.dart';

class ShowMeGenderScreenController extends GetxController {
  String showMeGenderValue = Get.arguments[0];
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxInt successStatus = 0.obs;

  List<Msg> genderList = [];
  List<Msg> mainGenderList = [];
  List<Msg> nonBinaryGenderList = [];
  Msg selectedGenderValue = Msg(id: "1", name: "Woman");

  SignUpPreference signUpPreference = SignUpPreference();

  UserPreference userPreference = UserPreference();

  String showMeGender = "";

  Future<void> getGenderFunction() async {
    isLoading(true);
    String url = ApiUrl.getGenderApi;
    log("geGenderFunction get url: $url");

    try {
      http.Response response = await http.get(Uri.parse(url));
      GenderModel getGenderModel =
          GenderModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        // Set api list in local list
        genderList = getGenderModel.msg;
        // Set Initial Value from api in local variable
        genderList.isNotEmpty ? selectedGenderValue = genderList[0] : null;

        for (var element in genderList) {

          if(element.name == "Woman" || element.name == "Man"||element.name=="Non-Binary") {
            mainGenderList.add(element);
          } else {
            nonBinaryGenderList.add(element);
          }

          if (element.name == showMeGenderValue) {
            selectedGenderValue = element;
          }
        }

        log('mainGenderList :${mainGenderList.length}');
        log('nonBinaryGenderList :${nonBinaryGenderList.length}');

        log("selectedGenderValue: $selectedGenderValue");
        // log("selectedGenderValueId: $selectedGenderValueId");
      } else {
        log("geGenderFunction Error");
      }
    } catch (e) {
      log("geGenderFunction Error $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveSexualityFunction(
      {required String key, required String value}) async {
    isLoading(true);
    String url = ApiUrl.completeSignUpApi;
    log('setSexualityFunction Api Url : $url');

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
          await userPreference.setStringValueInPrefs(
            key: UserPreference.isShowMeGenderKey,
            value: selectedGenderValue.name,
          );
          Get.back();
        } else {
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('setSexualityFunction Error :$e');
      rethrow;
    }
  }

  void radioButtonChangeFunction(Msg selectedValue) {
    isLoading(true);
    //TODO:edit gender on server
    selectedGenderValue = selectedValue;
    isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  initMethod() async {
    await getGenderFunction();
  }
}
