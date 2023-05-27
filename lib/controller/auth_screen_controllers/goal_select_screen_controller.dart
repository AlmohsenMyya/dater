import 'dart:convert';
import 'dart:developer';
import 'package:dater/constants/api_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/authentication_model/goal_select_screen_model/goal_model.dart';
import '../../screens/authentication_screen/interests_screen/interests_screen.dart';
import '../../utils/preferences/signup_preference.dart';


class GoalSelectScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;
  // RxString selectedvalue = "Serious relationship".obs;

  List<GoalData> goalList = [];
  GoalData selectedGoalData = GoalData(id: "1", name: "Serious relationship");

  SignUpPreference signUpPreference = SignUpPreference();

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

      } else {
        log("getGoalListFunction Error");
      }
    } catch (e) {
      log("getGoalListFunction Error $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  void radioButtonOnChangeFunction(GoalData selectedValue) {
    isLoading(true);
    selectedGoalData = selectedValue;
    isLoading(false);
  }

  Future<void> nextButtonFunction() async {
    await signUpPreference.setStringValueInPrefs(
      key: SignUpPreference.userGoalKey,
      value: selectedGoalData.id,
    );
    Get.to(() => InterestsScreen());
  }

  @override
  void onInit() {
    getGoalListFunction();
    super.onInit();
  }
}
