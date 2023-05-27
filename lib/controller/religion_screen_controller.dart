import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../constants/api_url.dart';
import '../constants/messages.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../model/religion_screen_models/religion_model.dart';
import '../utils/preferences/user_preference.dart';

class ReligionScreenController extends GetxController {
  String religionName = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  List<ReligionData> religionList = [];
  ReligionData selectedReligionData = ReligionData();

  UserPreference userPreference = UserPreference();

  /// Get Religion Function
  Future<void> getReligionFunction() async {
    isLoading(true);
    String url = ApiUrl.getReligionApi;
    log('getPoliticsFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('GET', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        ReligionModel religionModel = ReligionModel.fromJson(json.decode(value));
        successStatus.value = religionModel.statusCode;

        if(successStatus.value == 200) {
          religionList.clear();
          if(religionModel.msg.isNotEmpty) {
            religionList.addAll(religionModel.msg);
            log('politicsList Length : ${religionList.length}');

            for(int i=0; i < religionList.length; i++) {
              if(religionList[i].name == religionName) {
                religionList[i] = ReligionData(name: religionList[i].name,isSelected: true);
                selectedReligionData = religionList[i];
              }
            }
          }
        } else {
          log('getPoliticsFunction Else');
        }
      });

    } catch(e) {
      log('getPoliticsFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  void changeSelectedValue(ReligionData selectedValue) {
    selectedReligionData = selectedValue;
    loadUI();
  }

  /// Done Button Click Function
  Future<void> deneButtonClickFunction() async {
    await updateUserProfileFunction(
      key: AppMessages.religionApiText,
      value: selectedReligionData.name!,
    );
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
          await setSelectedReligionValueInPrefs();
          Get.back();
        } else {
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('updateUserProfileFunction Error :$e');
      rethrow;
    }
  }


  Future<void> setSelectedReligionValueInPrefs() async {
    userPreference.setStringValueInPrefs(key: UserPreference.religionKey, value: selectedReligionData.name!);
  }


  @override
  void onInit() {
    initMethod();
    super.onInit();
  }


  Future<void> initMethod() async {
    await getReligionFunction();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }

}