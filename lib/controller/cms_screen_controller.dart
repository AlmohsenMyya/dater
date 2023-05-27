import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/enums.dart';
import '../model/cms_screen_models/cms_model.dart';
import '../utils/preferences/user_preference.dart';

class CmsScreenController extends GetxController {
  CmsIdentify cmsIdentify = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  UserPreference userPreference = UserPreference();

  RxString cmsTitle = "".obs;
  RxString cmsData = "".obs;

  Future<void> getCmsDataFunction() async {
    isLoading(true);
    String url = getApiUrl();
    log("getCmsDataFunction ApiUrl : $url");

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('GET', Uri.parse(url));

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getChatListFunction Value : $value');
        CmsModel cmsModel = CmsModel.fromJson(json.decode(value));
        successStatus.value = cmsModel.statusCode;

        if(successStatus.value == 200) {
          cmsTitle.value = cmsModel.msg[0].name;
          cmsData.value = cmsModel.msg[0].info;
        } else {
          log('getCmsDataFunction Else');
        }
      });

    } catch(e) {
      log('getCmsDataFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  String getApiUrl() {
    String url = cmsIdentify == CmsIdentify.communityGuideline
        ? ApiUrl.getCommunityGuidelineApi
        : cmsIdentify == CmsIdentify.termAndCondition
            ? ApiUrl.getTermsAndConditionApi
            : ApiUrl.getPrivacyPolicyApi;
    return url;
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    // log('cmsIdentify : $cmsIdentify');
    await getCmsDataFunction();
  }

}