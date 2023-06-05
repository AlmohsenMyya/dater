import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:dater/utils/preferences/user_preference.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/messages.dart';
import '../../model/authentication_model/complete signup_screen_model/complete signup_model.dart';
import '../../model/authentication_model/interests screen_model/cateory_item_model.dart';
import '../../model/authentication_model/interests screen_model/get_interests _model.dart';
import '../../model/authentication_model/interests screen_model/save_interests_model.dart';
import '../../screens/index_screen/index_screen.dart';
import '../../utils/preferences/signup_preference.dart';

class InterestsScreenController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isSuccessStatus = false.obs;

  List<InterestsData> interestsData = []; // Api List

  List<String> categoryNameList = [];
  RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;
  RxInt selectedItemCount = 0.obs;
  List<String> selectedOptionIdList = [];

  SignUpPreference signUpPreference = SignUpPreference();
  UserPreference userPreference = UserPreference();

  Future<void> getInterestFunction() async {
    isLoading(true);
    String url = ApiUrl.getInterestsApi;
    log("getInterestFunction: $url");
    try {
      http.Response response = await http.get(Uri.parse(url));
      InterestModel getInterestModel =
          InterestModel.fromJson(json.decode(response.body));
      // InterestModel getInterestModel = InterestModel.fromJson(json.decode(Demo.demoString));

      if (response.statusCode == 200) {
        log("getInterestFunction.statusCode: ${response.statusCode}");
        log("getInterestFunction.body: ${response.body}");
        getInterestModel.msg.length;
        interestsData = getInterestModel.msg;

        if (getInterestModel.msg.isNotEmpty) {
          /// Create category name list - String type list
          for (var item in getInterestModel.msg) {
            if (categoryNameList.contains(item.categoryName) == false) {
              categoryNameList.add(item.categoryName);
              categoryList.add(CategoryItemModel(
                  categoryId: item.categoryId,
                  categoryName: item.categoryName,
                  options: []));
            }
          }

          for (int i = 0; i < getInterestModel.msg.length; i++) {
            for (int j = 0; j < categoryList.length; j++) {
              if (getInterestModel.msg[i].categoryId ==
                  categoryList[j].categoryId) {
                categoryList[j].options.add(
                      Option(
                        id: getInterestModel.msg[i].id,
                        name: getInterestModel.msg[i].name,
                        image: getInterestModel.msg[i].image,
                        isSelected: false,
                      ),
                    );
              }
            }
          }

          ///
          for (int i = 0; i < categoryList.length; i++) {
            for (int j = 0; j < categoryList[i].options.length; j++) {
              log('${categoryList[i].categoryName} => ${categoryList[i].options[j].name}:: name id ${categoryList[i].options[j].id}');
            }
          }
        } else {
          /// When api list getting empty that time coming here
        }
      }
    } catch (e) {
      log("getInterestFunction Error: $e");
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // Next Button Click Function
  Future<void> nextButtonClickFunction() async {
    // String selectedOptionIdString = "";
    // selectedOptionIdString = selectedOptionIdList.toString().substring(1, selectedOptionIdList.toString().length -1).replaceAll(" ", "");
    // log('selectedOptionIdString : $selectedOptionIdString');
    Fluttertoast.showToast(msg: "Please wait!");
    for (int i = 0; i < selectedOptionIdList.length; i++) {
      await saveInterestsFunction(selectedOptionIdList[i]);
    }
    await completeSignUpFunction();
    // await saveInterestsFunction(selectedOptionIdString);
  }

  Future<void> saveInterestsFunction(String interestedId) async {
    isLoading(true);
    String url = ApiUrl.saveInterestsApi;
    log("saveInterestsFunction Api Url: $url");

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['token'] = verifyToken;
      request.fields['interest_id'] = interestedId;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('Success value : $value');

        SaveInterestModel saveInterestModel =
            SaveInterestModel.fromJson(json.decode(value));

        if (saveInterestModel.statusCode == 200) {
          // Fluttertoast.showToast(msg: saveInterestModel.msg);
          // Get.offAll(()=> );
        } else if (saveInterestModel.statusCode == 400) {
          // Fluttertoast.showToast(msg: saveInterestModel.msg);
        } else {
          // Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      });
    } catch (e) {
      log("saveInterestsFunction:: $e");
    }

    // isLoading(false);
    // await completeSignUpFunction();
  }

  Future<void> completeSignUpFunction() async {
    isLoading(true);
    String url = ApiUrl.completeSignUpApi;
    log('Complete SignUp Api Url : $url');

    try {
      // Get Data from prefs
      String userEmail = await signUpPreference.getStringFromPrefs(
          key: SignUpPreference.signUpEmailKey);
      String userName = await signUpPreference.getStringFromPrefs(
          key: SignUpPreference.signUpFNameKey);
      String userSexuality = await signUpPreference.getStringFromPrefs(
          key: SignUpPreference.userSexualityKey);
      String userGender = await signUpPreference.getStringFromPrefs(
          key: SignUpPreference.userGenderKey);
      String userTargetGender = await signUpPreference.getStringFromPrefs(
          key: SignUpPreference.targetGenderKey);
      String userGoal = await signUpPreference.getStringFromPrefs(
          key: SignUpPreference.userGoalKey);
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);

      // api calling start
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['f_name'] = userName;
      request.fields['l_name'] = "";
      request.fields['sexuality'] = userSexuality;
      request.fields['gender'] = userGender;
      request.fields['token'] = verifyToken;
      request.fields['goal'] = userGoal;
      request.fields['target_gender'] = userTargetGender;
      request.fields['email'] = userEmail;

      log('Request Field : ${request.fields}');
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        CompleteSignupModel completeSignupModel =
            CompleteSignupModel.fromJson(json.decode(value));

        if (completeSignupModel.statusCode == 200) {
          Fluttertoast.showToast(msg: completeSignupModel.msg);

          await userPreference.setBoolValueInPrefs(
            key: UserPreference.completeRegister,
            value: true,
          );
          // Here set user is old
          await signUpPreference.setBoolValueInPrefs(
            key: SignUpPreference.isUserFirstTimeKey,
            value: false,
          );

          await userPreference.setBoolValueInPrefs(
            key: UserPreference.isUserLoggedInKey,
            value: true,
          );

          Get.offAll(() => IndexScreen());
        } else if (completeSignupModel.statusCode == 400) {
          Fluttertoast.showToast(msg: completeSignupModel.msg);
        } else {
          Fluttertoast.showToast(msg: AppMessages.apiCallWrong);
        }
      });
    } catch (e) {
      log('completeSignUpFunction Error :$e');
      rethrow;
    }

    isLoading(false);
  }

  // Select on interest click function
  void selectChoiceOnSelectFunction({
    required bool value,
    required int categoryIndex,
    required int categoryOptionIndex,
    required int optionId,
  }) {
    isLoading(true);
    selectedOptionIdList.clear();

    categoryList[categoryIndex].options[categoryOptionIndex].isSelected = value;

    for (int i = 0; i < categoryList.length; i++) {
      for (int j = 0; j < categoryList[i].options.length; j++) {
        if (categoryList[i].options[j].isSelected == true) {
          selectedOptionIdList.add(categoryList[i].options[j].id);
          log('Selected Id : ${categoryList[i].options[j].id}');
        }
      }
    }

    isLoading(false);
  }


  @override
  void onInit() {
    getInterestFunction();
    super.onInit();
  }
}
