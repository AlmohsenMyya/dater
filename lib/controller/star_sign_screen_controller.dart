import 'dart:convert';
import 'dart:developer';

import 'package:dater/model/star_sign_screen_model/star_sign_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import '../constants/messages.dart';
import '../model/star_sign_screen_model/save_star_sign_model.dart';
import '../utils/preferences/user_preference.dart';

class StarSignScreenController extends GetxController {
  String starSignName = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  List<StarSignData> starSignList = [];
  StarSignData selectedStarSign = StarSignData();

  UserPreference userPreference = UserPreference();


  /// Get Politics Function
  Future<void> getStarSignFunction() async {
    isLoading(true);
    String url = ApiUrl.getStarSignApi;
    log('getStarSignFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('GET', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        StarSignModel starSignModel = StarSignModel.fromJson(json.decode(value));
        successStatus.value = starSignModel.statusCode;

        if(successStatus.value == 200) {
          starSignList.clear();
          if(starSignModel.msg.isNotEmpty) {
            starSignList.addAll(starSignModel.msg);
            log('politicsList Length : ${starSignList.length}');

            for(int i=0; i < starSignList.length; i++) {
              if(starSignList[i].name == starSignName) {
                starSignList[i] = StarSignData(name: starSignList[i].name,isSelected: true);
                selectedStarSign = starSignList[i];
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

  void changeSelectedValue(StarSignData selectedValue) {
    selectedStarSign = selectedValue;
    loadUI();
  }


  /// Done Button Click Function
  Future<void> deneButtonClickFunction() async {
    await saveStarSignFunction();
  }


  Future<void> saveStarSignFunction() async {
   isLoading(true);
   String url = ApiUrl.setStarSignApi;
   log('saveStarSignFunction Api Url : $url');

   try {
     String verifyToken = await userPreference.getStringFromPrefs(
         key: UserPreference.userVerifyTokenKey);
     var request = http.MultipartRequest('POST', Uri.parse(url));
     request.fields['token'] = verifyToken;
     request.fields['star_sign'] = selectedStarSign.name!;

     log('Request Field : ${request.fields}');
     var response = await request.send();

     response.stream.transform(utf8.decoder).listen((value1) async {
       log('value : $value1');

       SaveStarSignModel saveStarSignModel = SaveStarSignModel.fromJson(json.decode(value1));
       successStatus.value = saveStarSignModel.statusCode;

       if (successStatus.value == 200) {
         await setSelectedStarSignValueInPrefs();
         Get.back();
       } else {
         log('saveStarSignFunction Else');
       }
     });


   } catch(e) {
     log('saveStarSignFunction Error :$e');
     rethrow;
   }

   isLoading(false);
  }



  Future<void> setSelectedStarSignValueInPrefs() async {
    userPreference.setStringValueInPrefs(key: UserPreference.starSignKey, value: selectedStarSign.name!);
  }


  @override
  void onInit() {
    initMethod();
    super.onInit();
  }


  Future<void> initMethod() async {
    await getStarSignFunction();
  }

  loadUI() {
    isLoading(true);
    isLoading(false);
  }


}