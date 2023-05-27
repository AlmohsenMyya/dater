import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/messages.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../model/politics_screen_model/politics_model.dart';
import '../utils/preferences/user_preference.dart';

class PoliticsScreenController extends GetxController {
  String politicsName = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  List<PoliticsData> politicsList = [];
  PoliticsData selectedPoliticData = PoliticsData();

  UserPreference userPreference = UserPreference();

  /// Get Politics Function
  Future<void> getPoliticsFunction() async {
    isLoading(true);
    String url = ApiUrl.getPoliticsApi;
    log('getPoliticsFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('GET', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        PoliticsModel politicsModel = PoliticsModel.fromJson(json.decode(value));
        successStatus.value = politicsModel.statusCode;

        if(successStatus.value == 200) {
          politicsList.clear();
          if(politicsModel.msg.isNotEmpty) {
            politicsList.addAll(politicsModel.msg);
            log('politicsList Length : ${politicsList.length}');

            for(int i=0; i < politicsList.length; i++) {
              if(politicsList[i].name == politicsName) {
                politicsList[i] = PoliticsData(name: politicsList[i].name,isSelected: true);
                selectedPoliticData = politicsList[i];
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


  void changeSelectedValue(PoliticsData selectedValue) {
    selectedPoliticData = selectedValue;
    loadUI();
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
          await setSelectedPoliticsValueInPrefs();
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


  /// Done Button Click Function
  Future<void> deneButtonClickFunction() async {
    await updateUserProfileFunction(
      key: AppMessages.politicsApiText,
      value: selectedPoliticData.name!,
    );
  }

  Future<void> setSelectedPoliticsValueInPrefs() async {
    userPreference.setStringValueInPrefs(key: UserPreference.politicsKey, value: selectedPoliticData.name!);
  }


  @override
  void onInit() {
    initMethod();
    super.onInit();
  }


  Future<void> initMethod() async {
    await getPoliticsFunction();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }

}