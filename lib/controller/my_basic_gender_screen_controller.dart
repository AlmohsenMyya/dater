import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../model/authentication_model/gender_select_screen_model/get_gender_model.dart';
import '../utils/preferences/user_preference.dart';

class MyBasicGenderScreenController extends GetxController {
  String genderValue = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  RxBool isShowOnProfile = true.obs;

  List<Msg> sexualityList = [];
  Msg selectedSexualityValue = Msg(id: "1", name: "Female");

  UserPreference userPreference = UserPreference();

  Future<void> getSexualityFunction() async {
    isLoading(true);
    String url = ApiUrl.getGenderApi;
    log('getSexualityFunction Api Url : $url');

    try {
      http.Response response = await http.get(Uri.parse(url));
      GenderModel getGenderModel =
          GenderModel.fromJson(json.decode(response.body));
      successStatus.value = getGenderModel.statusCode;

      if (successStatus.value == 200) {
        sexualityList.clear();
        sexualityList.addAll(getGenderModel.msg);

        for (var element in sexualityList) {
          if (element.name == genderValue) {
            selectedSexualityValue = element;
          }
        }

        log('sexualityList Length : ${sexualityList.length}');
      } else {
        log('getSexualityFunction Else');
      }
    } catch (e) {
      log('getSexualityFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  // Future<void> doneButtonFunction() async {
  //   await saveSexualityFunction();
  // }

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
            key: UserPreference.myBasicGenderValueKey,
            value: selectedSexualityValue.name,
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
    selectedSexualityValue = selectedValue;
    isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    log('genderValue : $genderValue');
    await getSexualityFunction();
  }
}
