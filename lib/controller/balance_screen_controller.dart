import 'dart:convert';
import 'dart:developer';

import 'package:dater/constants/api_url.dart';
import 'package:dater/model/balance_screen_model/steps_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/balance_screen_model/coin_model.dart';
import '../utils/preferences/user_preference.dart';

class BalanceScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt successStatus = 0.obs;

  RxString coinValue = "0".obs;
  UserPreference userPreference = UserPreference();

  Future<void> getSteps() async {
    log('permission activity');
    final physicalPermission = Permission.activityRecognition.request();

    if (await physicalPermission.isGranted) {
      log('permission granted');
      return;
    }
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  RxString status = '?'.obs, steps = ''.obs;
  RxString oldSteps = ''.obs;
  RxInt todaySteps = 0.obs;
  RxString tempDate = ''.obs;

  Future<void> initPlatformState() async {
    oldSteps.value = await userPreference.getStringFromPrefs(
        key: UserPreference.lastUpdatedSteps);
    tempDate.value = await userPreference.getStringFromPrefs(
        key: UserPreference.lastUpdatedStepsDate);
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onStepCountError);

    _stepCountStream = Pedometer.stepCountStream;

    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  Future<void> onStepCount(StepCount event) async {
    print(event);
    // if (steps.value == '') {
    //   updateStepsOnServer(event.steps);
    // }
    steps.value = event.steps.toString();
    todaySteps.value = event.steps - (int.tryParse(oldSteps.value) ?? 0);
    DateTime? lastUpdatedDate = DateTime.tryParse(tempDate.value);
    var now = DateTime.now();
    if (lastUpdatedDate != null) {
      DateTime tomorrowLastUpdatedDate =
          lastUpdatedDate.add(Duration(days: 1));
      if (now.isAfter(tomorrowLastUpdatedDate)) {
        log('reset today steps');
        updateStepsOnServer(event.steps);
      }
    }
  }

  updateStepsOnServer(int currentSteps) async {
    int lastUpdatedSteps = int.tryParse(oldSteps.value) ?? 0;
    log(name: 'lastUpdatingSteps', lastUpdatedSteps.toString());

    int newSteps = currentSteps - lastUpdatedSteps;
    log(name: 'newSteps', newSteps.toString());

    if (newSteps > 100) {
      // isLoading(true);
      String url = ApiUrl.updateStepsApi;
      log('updateSteps Api Url : $url');

      try {
        String verifyToken = await userPreference.getStringFromPrefs(
            key: UserPreference.userVerifyTokenKey);
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.fields['token'] = verifyToken;
        request.fields['num_steps'] = newSteps.toString();

        var response = await request.send();

        response.stream.transform(utf8.decoder).listen((value) async {
          log('updateSteps Api value : $value');
          StepsModel stepsModel = StepsModel.fromJson(json.decode(value));
          successStatus.value = stepsModel.statusCode;

          if (successStatus.value == 200) {
            await userPreference.setStringValueInPrefs(
              key: UserPreference.lastUpdatedSteps,
              value: currentSteps.toString(),
            );
            await userPreference.setStringValueInPrefs(
              key: UserPreference.lastUpdatedStepsDate,
              value: DateTime.now().toString(),
            );
            tempDate.value = await userPreference.getStringFromPrefs(
                key: UserPreference.lastUpdatedStepsDate);
            oldSteps.value = await userPreference.getStringFromPrefs(
                key: UserPreference.lastUpdatedSteps);
            coinValue.value = stepsModel.coins;
            log('New coinValue : ${coinValue.value}');
            todaySteps.value = 0;
          } else {
            log('updateSteps Else');
          }
        });
      } catch (e) {
        log('updateSteps Error :$e');
        rethrow;
      }
      // isLoading(false);
    }
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    steps.value = '0';
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    status.value = event.status;
  }

  /// Get My Coins
  Future<void> getMyCoinsFunction() async {
    isLoading(true);
    String url = ApiUrl.getCoinsApi;
    log('getMyCoinsFunction Api Url : $url');

    try {
      String verifyToken = await userPreference.getStringFromPrefs(
          key: UserPreference.userVerifyTokenKey);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['token'] = verifyToken;

      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        log('getMyCoinsFunction Api value : $value');
        CoinModel coinModel = CoinModel.fromJson(json.decode(value));
        successStatus.value = coinModel.statusCode;

        if (successStatus.value == 200) {
          coinValue.value = coinModel.msg;
          log('coinValue.value : ${coinValue.value}');
        } else {
          log('getMyCoinsFunction Else');
        }
      });
    } catch (e) {
      log('getMyCoinsFunction Error :$e');
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
    await getSteps();
    await getMyCoinsFunction();
    initPlatformState();
  }
}
