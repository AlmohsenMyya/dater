import 'dart:convert';
import 'dart:developer';
import 'package:dater/utils/preferences/user_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'models.dart';

class DemoController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;
  UserPreference userPreference = UserPreference();


  /// Update User Location
  Future<void> updateUserLocationFunction() async {
    isLoading(true);
    String url = ApiUrl.updateUserLocationApi;
    log('updateUserLocationFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value : $value');
        UpdateLocationModel updateLocationModel = UpdateLocationModel.fromJson(json.decode(value));
        successStatus.value = updateLocationModel.statusCode;

        if(successStatus.value == 200) {
          Fluttertoast.showToast(msg: updateLocationModel.msg);
        } else {
         log('updateUserLocationFunction Else');
        }

      });

    } catch(e) {
      log('updateUserLocationFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  /// Get User Age
  Future<void> getUserAgeFunction() async {
    isLoading(true);
    String url = ApiUrl.getUserAgeApi;
    log('getUserAgeFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value : $value');

        UserAgeModel userAgeModel = UserAgeModel.fromJson(json.decode(value));
        successStatus.value = userAgeModel.statusCode;

        if(successStatus.value == 200) {
          Fluttertoast.showToast(msg: userAgeModel.msg);
        } else {
          log('getUserAgeFunction Else');
        }
      });

    } catch(e) {
      log('getUserAgeFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

  /// Get Chat List Function
  /*Future<void> getChatListFunction() async {
    isLoading(true);
    String url = ApiUrl.getChatListApi;
    log('getChatListFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['sender_id'] = "2";

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getChatListFunction Value : $value');

        MessageListModel messageListModel = MessageListModel.fromJson(json.decode(value));
        successStatus.value = messageListModel.statusCode;

        if(successStatus.value == 200) {

        } else {
          log('sendChatMessageFunction Else');
        }

      });
    } catch(e) {
      log('sendChatMessageFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }*/

  /// Get Suggestion Function
  /*Future<void> getSuggestionFunction() async {
    isLoading(true);
    String url = ApiUrl.getSuggestionApi;
    log('getSuggestionFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getSuggestionFunction Value : $value');
        SuggestionsModel suggestionsModel = SuggestionsModel.fromJson(json.decode(value));
        successStatus.value = suggestionsModel.statusCode;
        if(successStatus.value == 200) {

        } else {
          log('getSuggestionFunction Else');
        }

      });
    } catch(e) {
      log('getSuggestionFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }*/


}