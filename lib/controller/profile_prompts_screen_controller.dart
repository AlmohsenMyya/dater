import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/messages.dart';
import '../model/profile_prompts_screen_models/profile_prompts_model.dart';
import '../utils/preferences/user_preference.dart';

class ProfilePromptsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  List<PromptsData> promptsList = [];
  // PromptsData promptsData = PromptsData();

  UserPreference userPreference = UserPreference();


  /// Get Profile Prompts List Function
  Future<void> getProfilePromptsFunction() async {
    isLoading(true);
    String url = ApiUrl.getPromptsApi;
    log('getProfilePromptsFunction Api URl :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('GET', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        ProfilePromptsModel profilePromptsModel = ProfilePromptsModel.fromJson(json.decode(value));
        successStatus.value = profilePromptsModel.statusCode;

        if(successStatus.value == 200) {
          if(profilePromptsModel.msg.isNotEmpty) {
            promptsList.addAll(profilePromptsModel.msg);
          }
        } else {
          log('getProfilePromptsFunction Else');
        }
      });

    } catch(e) {
      log('getProfilePromptsFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }
  Future<void> initMethod() async {
    await getProfilePromptsFunction();
  }
}