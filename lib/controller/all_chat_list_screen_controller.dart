import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dater/constants/messages.dart';
import 'package:http/http.dart' as http;
import 'package:dater/utils/preferences/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/api_url.dart';
import '../model/home_screen_model/matches_model.dart';
import 'package:dio/dio.dart' as dio;


class AllChatListScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  RxInt successStatus = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController searchTextFieldController = TextEditingController();
  RxBool rightSelected = true.obs;
  RxBool activeSelected = true.obs;
  RxBool panddingMess = true.obs;


  List<MatchUserData> matchesList = [];
  List<MatchUserData> searchMatchesList = [];
  UserPreference userPreference = UserPreference();

  var dioRequest = dio.Dio();

  /// Get Matches Function
  Future<void> getMatchesFunction() async {
    isLoading(true);
    String url = ApiUrl.matchesApi;
    log('Matches Api Url :$url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var formData = dio.FormData.fromMap({
        'token': verifyToken
      });

      var response = await dioRequest.post(url, data: formData);
      log('getMatches Response : ${response.data}');

      MatchesModel matchesModel = MatchesModel.fromJson(json.decode(response.data));
      successStatus.value = matchesModel.statusCode;

      if (successStatus.value == 200) {
        matchesList.clear();
        searchMatchesList.clear();
        if(matchesModel.msg.isNotEmpty) {
          matchesList.addAll(matchesModel.msg);
          searchMatchesList = matchesList;
          log('matchesList : ${matchesList.length}');
        }

      } else {
        log('getMatchesFunction Else');
      }

      /*var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream
          .transform(utf8.decoder)
          .listen((value) async {
        log("Matches value :$value");
        MatchesModel matchesModel = MatchesModel.fromJson(json.decode(value));
        matchesList.clear();
        searchMatchesList.clear();
        if(matchesModel.msg.isNotEmpty) {
          matchesList.addAll(matchesModel.msg);
          searchMatchesList = matchesList;
          log('matchesList : ${matchesList.length}');
        }
      });*/
    } catch (e) {
      log('getMatchesFunction Error :$e');
      rethrow;
    }

    isLoading(false);
  }

  // Future<void> getUserMatchesFunction() async {
  //   // isLoading(true);
  //   String url = ApiUrl.matchesApi;
  //   log('Matches Api Url :$url');
  //
  //   try {
  //     String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
  //     var formData = dio.FormData.fromMap({
  //       'token': verifyToken
  //     });
  //
  //     var response = await dioRequest.post(url, data: formData);
  //     log('getUserMatches Response : ${response.data}');
  //
  //     MatchesModel matchesModel = MatchesModel.fromJson(json.decode(response.data));
  //     successStatus.value = matchesModel.statusCode;
  //
  //     if (successStatus.value == 200) {
  //       matchesList.clear();
  //       searchMatchesList.clear();
  //       if(matchesModel.msg.isNotEmpty) {
  //         matchesList.addAll(matchesModel.msg);
  //         searchMatchesList = matchesList;
  //         log('matchesList : ${matchesList.length}');
  //       }
  //
  //     } else {
  //       log('getUserMatchesFunction Else');
  //     }
  //
  //     /*var request = http.MultipartRequest('POST', Uri.parse(url));
  //     request.fields['token'] = verifyToken;
  //
  //     var response = await request.send();
  //
  //     response.stream
  //         .transform(utf8.decoder)
  //         .listen((value) async {
  //       log("Matches value :$value");
  //       MatchesModel matchesModel = MatchesModel.fromJson(json.decode(value));
  //       matchesList.clear();
  //       searchMatchesList.clear();
  //       if(matchesModel.msg.isNotEmpty) {
  //         matchesList.addAll(matchesModel.msg);
  //         searchMatchesList = matchesList;
  //         log('matchesList : ${matchesList.length}');
  //       }
  //     });*/
  //   } catch (e) {
  //     log('getUserMatchesFunction Error :$e');
  //     rethrow;
  //   }
  //   loadUI();
  //   // isLoading(false);
  // }


  @override
  void onInit() {
    initMethod();
    super.onInit();
  }

  Future<void> initMethod() async {
    await getMatchesFunction();

    // Timer.periodic(const Duration(minutes: 2), (timer) async {
    //   await getUserMatchesFunction();
    // });
  }

  // loadUI() {
  //   isLoading(true);
  //   isLoading(false);
  // }

}
