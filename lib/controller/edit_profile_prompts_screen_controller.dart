import 'dart:convert';
import 'dart:developer';
import 'package:dater/model/star_sign_screen_model/save_star_sign_model.dart';
import 'package:http/http.dart' as http;
import 'package:dater/constants/api_url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/messages.dart';
import '../model/profile_prompts_screen_models/profile_prompts_model.dart';
import '../utils/preferences/user_preference.dart';


class EditProfilePromptsScreenController extends GetxController {
  PromptsData promptsData = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  TextEditingController typeController = TextEditingController();
  UserPreference userPreference = UserPreference();


  Future<void> saveButtonClick() async {
    if(typeController.text.isNotEmpty) {
      await savePromptsFunction();
    } else {
      Fluttertoast.showToast(msg: "Please type answer!");
    }
  }

  Future<void> savePromptsFunction() async {
    isLoading(true);
    String url = ApiUrl.setPromptsApi;
    log('savePromptsFunction Api Url :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['prompt_question_id'] = promptsData.id!;
      request.fields['answer'] = typeController.text.trim();

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('savePromptsFunction Value : $value');
        SaveStarSignModel savePromptsModel = SaveStarSignModel.fromJson(json.decode(value));
        successStatus.value = savePromptsModel.statusCode;

        if(successStatus.value == 200) {
          Get.back();
          Get.back();
        } else {
          log('savePromptsFunction Else');
        }

      });

    } catch(e) {
      log('savePromptsFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

}