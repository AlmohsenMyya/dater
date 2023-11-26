import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import '../constants/messages.dart';
import '../model/language_select_screen_model/language_model.dart';
import '../model/profile_screen_models/language_save_model.dart';
import '../utils/preferences/user_preference.dart';

class LanguageSelectScreenController extends GetxController {
  List<String> languages = Get.arguments[0];


  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  List<LanguageData> languageList = [];
  // LanguageData selectedLanguageValue = LanguageData();
  List<ChangeLanguageModel> changeLanguageList = [];


  UserPreference userPreference = UserPreference();

  /// Get Language Function
  Future<void> getLanguagesFunction() async {
    isLoading(true);
    String url = ApiUrl.getLanguageApi;
    log('getLanguagesFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('GET', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {

        LanguageModel languageModel = LanguageModel.fromJson(json.decode(value));
        successStatus.value = languageModel.statusCode;

        if(successStatus.value == 200) {
          languageList.clear();
          if(languageModel.msg.isNotEmpty) {
            languageList.addAll(languageModel.msg);
            log('politicsList Length : ${languageList.length}');

            for(int i=0; i < languageList.length; i++) {
              for(int j = 0; j < languages.length; j++) {
                if(languageList[i].name! == languages[j]) {
                  languageList[i] = LanguageData(name: languageList[i].name, isSelected: true);
                }
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

  /// When select any language that time call this function
  changeSelectedValue({required int i, required LanguageData singleItem, required bool value}) {
    languageList[i] = LanguageData(name: singleItem.name, isSelected: value);
    if(value == true) {
      changeLanguageList.add(ChangeLanguageModel(languageName: singleItem.name!, isSelected: true));
    } else {
      changeLanguageList.add(ChangeLanguageModel(languageName: singleItem.name!, isSelected: false));
    }
    loadUI();
  }

  Future<void> saveButtonCLickFunction() async {
    isLoading(true);
    for(int i =0; i< changeLanguageList.length; i++) {
      if(changeLanguageList[i].isSelected == true) {
        await setUserLanguageFunction(languageName: changeLanguageList[i].languageName);
      } else if(changeLanguageList[i].isSelected == false) {
        await deleteUserLanguageFunction(languageName: changeLanguageList[i].languageName);
      }
    }
    isLoading(false);
    Get.back();
  }


  /// Set Language Function
  Future<void> setUserLanguageFunction({required String languageName}) async {
    String url = ApiUrl.setUserLanguageApi;
    log('setUserLanguageFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['language'] = languageName;

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) async {
        log('setUserLanguageFunction Value : $value');

        LanguageSaveModel languageSaveModel = LanguageSaveModel.fromJson(json.decode(value));
        successStatus.value = languageSaveModel.statusCode;

        if(successStatus.value == 200) {
          log('setUserLanguageFunction successStatus :${successStatus.value}');
        } else {
          log('setUserLanguageFunction Else Else');
        }

      });
    } catch(e) {
      log('setUserLanguageFunction Error :$e');
      rethrow;
    }

  }

  /// Remove Language FUnction
  Future<void> deleteUserLanguageFunction({required String languageName}) async {
    // isLoading(true);
    String url = ApiUrl.setUserLanguageApi;
    log('deleteUserLanguageFunction A[pi Url :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['language'] = languageName;
      request.fields['action'] = "remove";

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) async {
        log('setUserLanguageFunction Value : $value');

        LanguageSaveModel languageSaveModel = LanguageSaveModel.fromJson(json.decode(value));
        successStatus.value = languageSaveModel.statusCode;

        if(successStatus.value == 200) {
          log('setUserLanguageFunction successStatus :${successStatus.value}');
        } else {
          log('setUserLanguageFunction Else Else');
        }

      });

    } catch(e) {
      log('deleteUserLanguageFunction Error :$e');
      rethrow;
    }

    // isLoading(false);
  }

  /// Save Button Function
  Future<void> saveButtonClickFunction() async {
    for(int i =0; i < languageList.length; i++) {
      if(languageList[i].isSelected == true) {
        await setUserLanguageFunction(languageName: languageList[i].name!);
      }
    }
  }


  Future<void> setLanguageInPrefs() async {
    List<String> selectedLanguageList = [];
    for(int i = 0; i < languageList.length; i++) {
      if(languageList[i].isSelected == true) {
        selectedLanguageList.add(languageList[i].name!);
      }
    }
    userPreference.setLanguageListOfStringInPrefs( value: selectedLanguageList);
  }




  @override
  void onInit() {
    initMethod();
    super.onInit();
  }


  Future<void> initMethod() async {
    await getLanguagesFunction();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}



class ChangeLanguageModel {
  String languageName;
  bool isSelected;

  ChangeLanguageModel({required this.languageName, required this.isSelected});
}