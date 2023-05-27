import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';
import '../constants/messages.dart';
import '../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../model/authentication_model/goal_select_screen_model/goal_model.dart';
import '../utils/preferences/signup_preference.dart';
import '../utils/preferences/user_preference.dart';

class LookingForScreenController extends GetxController {
  String lookingForValue = Get.arguments[0];

  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  RxBool isShowOnProfile = true.obs;
  List<GoalData> goalList = [];
  GoalData selectedGoalData = GoalData(id: "1", name: "Serious relationship");

  SignUpPreference signUpPreference = SignUpPreference();
  UserPreference userPreference = UserPreference();


  Future<void> getGoalListFunction() async {
    isLoading(true);

    String url = ApiUrl.getGoalApi;
    log("getGoalListFunction get url: $url");

    try {
      http.Response response = await http.get(Uri.parse(url));

      GoalModel goalModel =
      GoalModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        log("response.statusCode: ${response.statusCode}");
        log("response.body: ${response.body}");
        goalList = goalModel.msg;
        goalList.isNotEmpty ? selectedGoalData = goalList[0] : null;

        for(var element in goalList) {
          if(element.name == lookingForValue) {
            selectedGoalData = element;
          }
        }

      } else {
        log("getGoalListFunction Error");
      }
    } catch (e) {
      log("getGoalListFunction Error $e");
      rethrow;
    }/* finally {
      isLoading(false);
    }*/

    isLoading(false);
  }

  Future<void> doneButtonFunction() async {
    await updateUserProfileFunction(
      key: AppMessages.goalApiText,
      value: selectedGoalData.id,
    );
  }

  Future<void> updateUserProfileFunction(
      {required String key, required String value}) async {
    isLoading(true);
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
          await userPreference.setStringValueInPrefs(key: UserPreference.myBasicLookingForValueKey, value: selectedGoalData.name);
          /*await signUpPreference.setStringValueInPrefs(
            key: SignUpPreference.userGoalKey,
            value: selectedGoalData.id,
          );*/
          Get.back();
        } else {
          log('updateUserProfileFunction Else');
        }
      });
    } catch (e) {
      log('updateUserProfileFunction Error :$e');
      rethrow;
    }

    isLoading(false);
  }

  void radioButtonOnChangeFunction(GoalData selectedValue) {
    isLoading(true);
    selectedGoalData = selectedValue;
    isLoading(false);
  }

  Future<void> initMethod() async {
    await getGoalListFunction();
  }

  @override
  void onInit() {
    initMethod();
    super.onInit();
  }
}
