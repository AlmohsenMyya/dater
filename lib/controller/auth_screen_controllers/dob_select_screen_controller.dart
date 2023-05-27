import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dater/constants/api_url.dart';
import 'package:dater/utils/preferences/signup_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/messages.dart';
import '../../model/dob_select_screen_model/dob_save_model.dart';
import '../../screens/authentication_screen/gender_select_screen/gender_select_screen.dart';
import '../../utils/preferences/user_preference.dart';

class DobSelectScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;
  RxString dobString = "YYYY".obs;
  DateTime tempDobString = DateTime.now();

  SignUpPreference signUpPreference = SignUpPreference();
  UserPreference userPreference = UserPreference();

  setDobInStringFunction() {
    dobString.value = DateFormat("yyyy").format(tempDobString);
    Get.back();
  }


  Future<void> nextButtonFunction() async {
    int currentYear = 0;
    int selectedYear = 0;
    if(dobString.value != "YYYY") {
      currentYear = int.parse(DateFormat("yyyy").format(DateTime.now()));
      selectedYear = int.parse(dobString.value);
    }

    if(dobString.value == "YYYY") {
      Fluttertoast.showToast(msg: "Please select birth Year");
    } else if(currentYear - selectedYear <= 18) {
      Fluttertoast.showToast(msg: "Your age must be +18");
    }
    else {
      await saveDobFunction();
    }
  }


  /// Save Dob Function
  Future<void> saveDobFunction() async {
    isLoading(true);
    String url = ApiUrl.saveBirthYearApi;
    log('saveDobFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(key: UserPreference.userVerifyTokenKey);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;
      request.fields['year'] = dobString.value;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('value : $value');
        DobSaveModel dobSaveModel = DobSaveModel.fromJson(json.decode(value));
        successStatus.value = dobSaveModel.statusCode;

        if(successStatus.value == 200) {
          Fluttertoast.showToast(msg: dobSaveModel.msg);
          await signUpPreference.setStringValueInPrefs(key: SignUpPreference.userDobKey, value: dobString.value);
          Get.to(() => GenderSelectScreen());
        } else if(successStatus.value == 400) {
          Fluttertoast.showToast(msg: dobSaveModel.msg);
        }
        else {
          log('saveDobFunction Else');
        }

      });
    } catch(e) {
      log('saveDobFunction Error :$e');
      rethrow;
    }
    isLoading(false);
  }

}